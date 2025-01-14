output "vpc_and_firewall_details" {
  description = "VPC 및 방화벽 모듈의 모든 세부 정보"
  value = {
    vpc = {
      id        = module.vpc.id        # VPC 리소스 ID
      self_link = module.vpc.self_link # VPC URI
      name      = module.vpc.name      # VPC 이름
      region    = module.vpc.region    # VPC 리전
      subnets   = module.vpc.subnets   # VPC 서브넷 목록
    }
    firewall = {
      id                 = module.firewall.id                 # 방화벽 리소스 ID
      name               = module.firewall.name               # 방화벽 이름
      network            = module.firewall.network            # 방화벽이 속한 네트워크
      direction          = module.firewall.direction          # 트래픽 방향 (INGRESS/EGRESS)
      priority           = module.firewall.priority           # 방화벽 규칙 우선 순위
      source_ranges      = module.firewall.source_ranges      # 소스 IP 범위 목록
      target_tags        = module.firewall.target_tags        # 대상 태그 목록
      allow              = module.firewall.allow              # 방화벽 ALLOW 규칙
      deny               = module.firewall.deny               # 방화벽 DENY 규칙
      log_config         = module.firewall.log_config         # 방화벽 로그 설정
      creation_timestamp = module.firewall.creation_timestamp # 방화벽 생성 타임스탬프
      self_link          = module.firewall.self_link          # 방화벽 URI
    }
  }
}
