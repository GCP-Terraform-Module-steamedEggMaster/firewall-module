# 방화벽 리소스 ID 출력
output "id" {
  description = "방화벽 리소스의 고유 ID"
  value       = google_compute_firewall.firewall_rule.id
}

# 방화벽 이름 출력
output "name" {
  description = "방화벽 리소스의 이름"
  value       = google_compute_firewall.firewall_rule.name
}

# 방화벽이 속한 네트워크 출력
output "network" {
  description = "방화벽 리소스가 속한 네트워크 이름 또는 self_link"
  value       = google_compute_firewall.firewall_rule.network
}

# 방화벽 설명 출력
output "description" {
  description = "방화벽 리소스의 설명"
  value       = google_compute_firewall.firewall_rule.description
}

# 트래픽 방향 출력
output "direction" {
  description = "방화벽 트래픽 방향 (INGRESS 또는 EGRESS)"
  value       = google_compute_firewall.firewall_rule.direction
}

# 방화벽 우선 순위 출력
output "priority" {
  description = "방화벽 규칙 우선 순위 (낮을수록 우선 순위 높음)"
  value       = google_compute_firewall.firewall_rule.priority
}

# 방화벽 대상 IP 범위 출력
output "destination_ranges" {
  description = "방화벽 리소스의 대상 IP 범위 (CIDR 형식)"
  value       = google_compute_firewall.firewall_rule.destination_ranges
}

# 방화벽 소스 IP 범위 출력
output "source_ranges" {
  description = "방화벽 리소스의 소스 IP 범위 (CIDR 형식)"
  value       = google_compute_firewall.firewall_rule.source_ranges
}

# 방화벽 소스 태그 출력
output "source_tags" {
  description = "방화벽 리소스의 소스 태그 목록"
  value       = google_compute_firewall.firewall_rule.source_tags
}

# 방화벽 소스 서비스 계정 출력
output "source_service_accounts" {
  description = "방화벽 리소스의 소스 서비스 계정 목록"
  value       = google_compute_firewall.firewall_rule.source_service_accounts
}

# 방화벽 대상 태그 출력
output "target_tags" {
  description = "방화벽 리소스의 대상 태그 목록"
  value       = google_compute_firewall.firewall_rule.target_tags
}

# 방화벽 대상 서비스 계정 출력
output "target_service_accounts" {
  description = "방화벽 리소스의 대상 서비스 계정 목록"
  value       = google_compute_firewall.firewall_rule.target_service_accounts
}

# 방화벽 비활성화 여부 출력
output "disabled" {
  description = "방화벽 리소스의 비활성화 여부"
  value       = google_compute_firewall.firewall_rule.disabled
}

# 방화벽 프로젝트 ID 출력
output "project" {
  description = "방화벽 리소스가 속한 GCP 프로젝트 ID"
  value       = google_compute_firewall.firewall_rule.project
}

# 방화벽 ALLOW 규칙 출력
output "allow" {
  description = "방화벽 리소스의 ALLOW 규칙 목록"
  value       = google_compute_firewall.firewall_rule.allow
}

# 방화벽 DENY 규칙 설정
output "firewall_deny" {
  description = "방화벽 리소스의 DENY 규칙 목록"
  value       = google_compute_firewall.firewall_rule.deny
}

# 방화벽 로그 설정 훌력
output "log_config" {
  description = "방화벽 리소스의 로그 설정"
  value       = google_compute_firewall.firewall_rule.log_config
}

# 방화벽 생성 타임스탬프 출력
output "creation_timestamp" {
  description = "방화벽 리소스의 생성 타임스탬프 (RFC3339 형식)"
  value       = google_compute_firewall.firewall_rule.creation_timestamp
}

# 방화벽 URI 출력
output "self_link" {
  description = "방화벽 리소스의 URI"
  value       = google_compute_firewall.firewall_rule.self_link
}
