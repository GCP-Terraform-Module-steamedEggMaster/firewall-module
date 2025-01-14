# firewall-module
GCP Terraform Firewall Module Repo

이 모듈은 GCP에서 방화벽(Firewall) 규칙을 생성하고 관리하기 위한 Terraform 모듈입니다. <br>
이 모듈은 VPC 네트워크와 연동하여 방화벽 규칙을 간단하게 설정할 수 있도록 설계되었습니다.

<br>

## 📑 **목차**
1. [모듈 특징](#모듈-특징)
2. [사용 방법](#사용-방법)
    1. [사전 준비](#1-사전-준비)
    2. [입력 변수](#2-입력-변수)
    3. [모듈 호출 예시](#3-모듈-호출-예시)
    4. [출력값 (Outputs)](#4-출력값-outputs)
    5. [지원 버전](#5-지원-버전)
    6. [모듈 개발 및 관리](#6-모듈-개발-및-관리)
3. [테스트](#terratest를-이용한-테스트)
4. [주요 버전 관리](#주요-버전-관리)
5. [기여](#기여-contributing)
6. [라이선스](#라이선스-license)

---

## 모듈 특징

- VPC 네트워크와 연동된 방화벽 규칙 생성 및 관리.
- IPv4 및 IPv6 트래픽 제어 지원.
- 트래픽 허용/차단 규칙을 상세하게 구성 가능.
- 특정 태그, 서비스 계정 및 IP 범위를 기반으로 한 세분화된 규칙 제공.

---

## 사용 방법

### 1. 사전 준비

다음 사항을 확인하세요:
1. Google Cloud 프로젝트 준비.
2. 적절한 IAM 권한 필요: `roles/compute.securityAdmin`.
3. 방화벽 규칙이 적용될 VPC 네트워크 준비.

<br>

### 2. 입력 변수

### 2. 입력 변수

| 변수명            | 타입           | 필수 여부 | 기본값 | 설명                                              |
|-------------------|----------------|-----------|--------|---------------------------------------------------|
| `name`           | string         | ✅        | 없음   | 방화벽 규칙 이름                                   |
| `network`        | string         | ✅        | 없음   | 방화벽 규칙이 적용될 VPC 네트워크                 |
| `description`    | string         | ❌        | null   | 방화벽 리소스의 설명                               |
| `direction`      | string         | ❌        | "INGRESS" | 트래픽 방향 (INGRESS 또는 EGRESS)                 |
| `priority`       | number         | ❌        | 1000   | 방화벽 규칙 우선순위 (낮을수록 높은 우선순위)      |
| `source_ranges`  | list(string)   | ❌        | []     | INGRESS 트래픽의 소스 IP 범위                      |
| `destination_ranges` | list(string)| ❌        | []     | EGRESS 트래픽의 대상 IP 범위                      |
| `source_tags`    | list(string)   | ❌        | null   | 소스 네트워크 태그 (INGRESS 전용)                  |
| `target_tags`    | list(string)   | ❌        | null   | 방화벽 규칙이 적용될 대상 네트워크 태그            |
| `source_service_accounts` | list(string) | ❌ | null | 소스 서비스 계정 목록                             |
| `target_service_accounts` | list(string) | ❌ | null | 대상 서비스 계정 목록                             |
| `allow`          | list(object)   | ❌        | []     | 허용되는 트래픽 규칙 (프로토콜 및 포트 포함)       |
| `deny`           | list(object)   | ❌        | []     | 차단되는 트래픽 규칙 (프로토콜 및 포트 포함)       |
| `log_config`     | object         | ❌        | null   | 방화벽 로그 설정                                   |
| `disabled`       | bool           | ❌        | false  | 방화벽 비활성화 여부                              |
| `project`        | string         | ❌        | null   | 방화벽 리소스가 속한 GCP 프로젝트 ID              |
| `timeout_create` | string         | ❌        | "20m"  | 리소스 생성 제한 시간                              |
| `timeout_update` | string         | ❌        | "20m"  | 리소스 업데이트 제한 시간                          |
| `timeout_delete` | string         | ❌        | "20m"  | 리소스 삭제 제한 시간                              | 

<br>

### 3. 모듈 호출 예시

```hcl
module "firewall" {
  source      = "./firewall-module"
  name        = "allow-ssh"
  network     = "projects/my-project/global/networks/my-vpc"
  direction   = "INGRESS"
  action      = "ALLOW"
  priority    = 100
  source_ranges = ["0.0.0.0/0"]
  
  allow = [
    {
      protocol = "tcp"
      ports    = ["22"]
    }
  ]

  log_config = {
    enable = true
  }
}
```

<br>

### 4. 출력값 (Outputs)

| 출력명                 | 설명                                          |
|------------------------|-----------------------------------------------|
| `id`                  | 방화벽 리소스의 고유 ID                        |
| `name`                | 방화벽 리소스의 이름                           |
| `network`             | 방화벽 리소스가 속한 네트워크 이름 또는 self_link |
| `description`         | 방화벽 리소스의 설명                           |
| `direction`           | 방화벽 트래픽 방향 (INGRESS 또는 EGRESS)         |
| `priority`            | 방화벽 규칙 우선 순위 (낮을수록 우선 순위 높음)   |
| `destination_ranges`  | 방화벽 리소스의 대상 IP 범위 (CIDR 형식)         |
| `source_ranges`       | 방화벽 리소스의 소스 IP 범위 (CIDR 형식)         |
| `source_tags`         | 방화벽 리소스의 소스 태그 목록                  |
| `source_service_accounts` | 방화벽 리소스의 소스 서비스 계정 목록         |
| `target_tags`         | 방화벽 리소스의 대상 태그 목록                  |
| `target_service_accounts` | 방화벽 리소스의 대상 서비스 계정 목록         |
| `disabled`            | 방화벽 리소스의 비활성화 여부                   |
| `project`             | 방화벽 리소스가 속한 GCP 프로젝트 ID            |
| `allow`               | 방화벽 리소스의 ALLOW 규칙 목록                 |
| `deny`                | 방화벽 리소스의 DENY 규칙 목록                  |
| `log_config`          | 방화벽 리소스의 로그 설정                       |
| `creation_timestamp`  | 방화벽 리소스의 생성 타임스탬프 (RFC3339 형식)   |
| `self_link`           | 방화벽 리소스의 URI                             |

<br>

### 5. 지원 버전

#### a.  Terraform 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `1.10.3`   | 최신 버전, 지원 및 테스트 완료                  |

#### b. Google Provider 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `~> 4.0`  | 최소 지원 버전                   |

<br>

### 6. 모듈 개발 및 관리

- **저장소 구조**:
  ```
  firewall-module/
    ├── .github/workflows/  # github actions 자동화 테스트
    ├── examples/           # 테스트를 위한 루트 모듈 모음 디렉터리
    ├── test/               # 테스트 구성 디렉터리
    ├── main.tf             # 모듈의 핵심 구현
    ├── variables.tf        # 입력 변수 정의
    ├── outputs.tf          # 출력 정의
    ├── versions.tf         # 버전 정의
    ├── README.md           # 문서화 파일
  ```

<br>

---

### Terratest를 이용한 테스트
이 모듈을 테스트하려면 제공된 Go 기반 테스트 프레임워크를 사용하세요. 아래를 확인하세요:

1. Terraform 및 Go 설치.
2. 필요한 환경 변수 설정.
3. 테스트 실행:
```bash
go test -v ./test
```

<br>

## 주요 버전 관리
이 모듈은 [Semantic Versioning](https://semver.org/)을 따릅니다.  
안정된 버전을 사용하려면 `?ref=<version>`을 활용하세요:

```hcl
source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/firewall-module.git?ref=v1.0.0"
```

### Module ref 버전
| Major | Minor | Patch |
|-----------|-----------|----------|
| `1.0.0`   |    |   |

<br>

## 기여 (Contributing)
기여를 환영합니다! 버그 제보 및 기능 요청은 GitHub Issues를 통해 제출해주세요.

<br>

## 라이선스 (License)
[MIT License](LICENSE)