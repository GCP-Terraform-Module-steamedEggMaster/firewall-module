variable "name" {
  description = "방화벽 이름"
  type        = string
}

variable "network" {
  description = "네트워크 이름 또는 self_link"
  type        = string
}

variable "description" {
  description = "리소스 설명"
  type        = string
  default     = null
}

variable "direction" {
  description = "트래픽 방향 (INGRESS 또는 EGRESS)"
  type        = string
  default     = "INGRESS"
}

variable "priority" {
  description = "규칙 우선 순위 (0-65535)"
  type        = number
  default     = 1000
}

variable "destination_ranges" {
  description = "대상 IP 범위 (CIDR 형식)"
  type        = list(string)
  default     = []
}

variable "source_ranges" {
  description = "소스 IP 범위 (CIDR 형식)"
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "소스 태그 목록"
  type        = list(string)
  default     = null
}

variable "source_service_accounts" {
  description = "소스 서비스 계정 목록"
  type        = list(string)
  default     = null
}

variable "target_tags" {
  description = "대상 태그 목록"
  type        = list(string)
  default     = null
}

variable "target_service_accounts" {
  description = "대상 서비스 계정 목록"
  type        = list(string)
  default     = null
}

variable "disabled" {
  description = "방화벽 비활성화 여부"
  type        = bool
  default     = false
}

variable "allow" {
  description = "ALLOW 규칙 목록"
  type = list(object({
    protocol = string
    ports    = optional(list(string), [])
  }))
  default = []
}

variable "deny" {
  description = "DENY 규칙 목록"
  type = list(object({
    protocol = string
    ports    = optional(list(string), [])
  }))
  default = []
}

variable "log_config" {
  description = "로그 설정"
  type = object({
    metadata = string
  })
  default = null
}

variable "project" {
  description = "GCP 프로젝트 ID"
  type        = string
  default     = null
}

variable "timeout_create" {
  description = "생성 타임아웃"
  type        = string
  default     = "20m"
}

variable "timeout_update" {
  description = "업데이트 타임아웃"
  type        = string
  default     = "20m"
}

variable "timeout_delete" {
  description = "삭제 타임아웃"
  type        = string
  default     = "20m"
}