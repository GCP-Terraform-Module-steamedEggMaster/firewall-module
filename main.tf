resource "google_compute_firewall" "firewall_rule" {
  # 필수 설정
  name    = var.name    # 방화벽 이름 (RFC1035 규칙 준수)
  network = var.network # 방화벽이 적용될 네트워크 이름 또는 self_link

  # 설명 및 일반 설정
  description = var.description # 방화벽 설명 (Optional)
  direction   = var.direction   # 트래픽 방향 (INGRESS 또는 EGRESS)
  priority    = var.priority    # 규칙 우선 순위 (낮을수록 우선순위 높음, 기본값: 1000)

  # 트래픽 대상 및 소스 설정
  destination_ranges = var.destination_ranges # 대상 IP 범위 목록 (CIDR 형식)

  # 조건적으로 설정: source_tags 또는 source_service_accounts
  dynamic "source_tags" {
    for_each = var.source_tags != null && var.source_service_accounts == null ? [1] : []
    content {
      source_tags = var.source_tags
    }
  }

  dynamic "source_service_accounts" {
    for_each = var.source_service_accounts != null && var.source_tags == null ? [1] : []
    content {
      source_service_accounts = var.source_service_accounts
    }
  }

  # 조건적으로 설정: target_tags 또는 target_service_accounts
  dynamic "target_tags" {
    for_each = var.target_tags != null && var.target_service_accounts == null ? [1] : []
    content {
      target_tags = var.target_tags
    }
  }

  dynamic "target_service_accounts" {
    for_each = var.target_service_accounts != null && var.target_tags == null ? [1] : []
    content {
      target_service_accounts = var.target_service_accounts
    }
  }

  # 기타 설정
  disabled = var.disabled # 방화벽 비활성화 여부 (기본값: false)
  project  = var.project  # 방화벽이 속한 GCP 프로젝트 ID

  # ALLOW 규칙
  dynamic "allow" {
    for_each = var.allow # ALLOW 규칙의 목록 반복 처리
    content {
      protocol = allow.value.protocol # 허용할 프로토콜 (예: tcp, udp, icmp 등)
      ports    = allow.value.ports    # 허용할 포트 범위 목록 (Optional)
    }
  }

  # DENY 규칙
  dynamic "deny" {
    for_each = var.deny # DENY 규칙의 목록 반복 처리
    content {
      protocol = deny.value.protocol # 차단할 프로토콜 (예: tcp, udp, icmp 등)
      ports    = deny.value.ports    # 차단할 포트 범위 목록 (Optional)
    }
  }

  # 로그 설정
  dynamic "log_config" {
    for_each = var.log_config != null ? [1] : [] # 로그 설정이 있는 경우 반복 처리
    content {
      metadata = var.log_config.metadata # 로그에 포함될 메타데이터 설정
    }
  }

  # 타임아웃 설정
  timeouts {
    create = var.timeout_create # 방화벽 생성 타임아웃 (기본값: 20m)
    update = var.timeout_update # 방화벽 업데이트 타임아웃 (기본값: 20m)
    delete = var.timeout_delete # 방화벽 삭제 타임아웃 (기본값: 20m)
  }
}
