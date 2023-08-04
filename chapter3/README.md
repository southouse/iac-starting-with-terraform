# Chapter3

## terraform init
- 테라폼 구성 파일이 있는 작업 디렉토리를 초기화
- `terraform init`이 처음 실행되는 디렉토리를 루트 모듈이라 함
- `0.14버전` 이후에 프로바이더 종속성을 고정시키는 `.terraform.lock.hcl`이 추가됨

## terraform validate
- 디렉토리에 있는 테라폼 구성 파일의 유효성 확인
- `-no-color` 옵션은 로컬이 아닌 외부 실행 환경(젠킨스, Terraform Cloud 등)을 사용하는 경우 색상 표기 문자 없이 출력하게 함
- `-json` 옵션으로 실행 결과를 JSON 형태로 출력

## terraform plan & apply
- `plan`은 인프라의 변경 사항에 관한 실행 계획을 생성하고 적용 전 예상한 구성이 맞는지 검토
- `apply`는 `plan`을 기반으로 작업을 실행
- `plan detailed-exitcode` 옵션은 **exitcode**가 환경 변수로 구성
   ```bash
   > terraform plan -detailed-exitcode
   > echo $?
   2
   ```
- exitcode 각 숫자의 의미
  - 0: 변경 사항이 없는 성공
  - 1: 오류가 있음
  - 2: 변경 사항이 있는 성공
- `plan -out=${파일명}` 옵션은 플랜 결과가 바이너리 형태로 생성
  - `terraform apply ${파일명}`을 이용해 사용
- 멱등성(idempotence)를 갖고 있기 때문에 상태를 관리하고 동일한 구성에 대해서는 다시 실행하거나 변경하는 작업을 수행하지 않음
- 코드 상태와 적용할 상태를 비교해 일치시키는 동작을 수행
- `-replace` 옵션을 통해 변경된 부분은 없지만 리소스를 삭제 후 생성
- `-auto-approve` 옵션으로 승인 절차 없이 수행 (주의해서 사용)

## terraform destroy
- 테라폼 구성에서 관리하는 모든 개체를 제거하는 명령
- `plan -destroy -out=${파일명}` 옵션 사용 가능
- `-auto-approve` 옵션 사용 가능

## terraform fmt
- 코드의 가독성을 높이기 위해 사용
- 표준 형식과 표준 스타일로 적용
- `-recursive` 옵션으로 하위 디렉토리의 테라폼 구성 파일을 모두 포함해 적용

## 테라폼 블록
- 버전 표기법
  - `=` 는 선언된 버전만을 허용
  - `>= 1.0.0`는 1.0.0 버전 이상의 모든 버전을 허용
  - `~> 1.0.0`는 1.0.x의 버전만 허용하고 1.x 버전은 허용하지 않음
  - `>= 1.0, < 2.0.0`는 1.0이상 2.0미만의 버전 허용 (섞어서 사용 가능)
- Cloud 블록
- 백엔드 블록
  - 저장되는 State 파일의 저장 위치를 선언
  - 하나의 백엔드만 허용
  - `.terraform.tfstate.lock.info` 파일이 생성되면서 해당 State를 동시에 사용하지 못하도록 잠금
  - 백엔드가 설정되면, 다시 `terraform init` 명령을 수행해 State 위치를 재설정
    - `-migrate-state` 옵션으로 이전 구성에서 최신의 state 스냅샷을 읽고 기록된 정보를 새 구성으로 전환
    - `-reconfigure` 옵션으로 init 실행 전 state 파일을 삭제해 테라폼을 처음 사용할 때 처럼 이 디렉토리를 초기화

## 리소스
- 종속성을 갖는 리소스는 `terraform init` 시에 프로바이더를 설치
  - ex. `aws_instance` 리소스 유형을 추가하면 AWS 프로바이더가 설치
- 속성 참조
  - 인수: 리소스 생성 시 사용자가 선언하는 값
  - 속성: 사용자가 설정하는 것은 불가능, 리소스 생성 이후 획득 가능한 리소스 고유 값

## 종속성
- 각 요소의 생성 순서를 구분
  - 암시적 종속성
  - 명시적 종속성 -> `depends_on`
- `terraform graph` 명령을 통해 수행되는 단계의 정의를 확인
  - ![Screenshot 2023-08-04 at 16 31 28](https://github.com/southouse/iac-starting-with-terraform/assets/35317926/3a449e75-e1fb-4b53-8726-d01f6290ec69)

## 수명주기
- `create_before_destory`: 리소스 수정 시 신규 리소스를 우선 생성하고 기존 리소스 삭제
  - ex. 같은 리소스 이름에 대해서 `true` 옵션을 주면, 리소스를 생성하고 삭제하는 과정에서 이름이 같은 리소스기 때문에 리소스가 전부 삭제될 수 있어 주의
- `prevent_destroy`: 해당 리소스를 삭제하려 할 때 명시적으로 거부
- `ignore_changes`: 리소스 요소에 선언된 인수의 변경 사항을 테라폼 실행 시 무시
- `precondition`: 리소스 요소에 선언된 인수의 조건을 검증
  - 검증된 이미지 아이디를 사용하는지, 스토리지의 암호화 설정이 되어 있는지 등과 같은 구성을 미리 확인하고 사전에 잘못된 리소스를 프로비저닝 하지 않기 위해 예방
- `postcondition`: Plan과 Apply 이후의 결과를 속성 값으로 검증

## 데이터 소스 구성
- 데이터 소스 속성을 참조 할 땐 `data.` 로 시작

## 입력 변수
- 일반적인 변수 선언 방식과 달리 Plan 수행 시 값을 입력
- 예약 변수 이름 (사용 불가능)
  - source
  - version
  - providers
  - count
  - for_each
  - lifecycle
  - depends_on
  - locals
- 유형
  - 기본 유형
    - string
    - number
    - bool
    - any: 모든 유형 허용
  - 집합 유형
    - list: 인덱스 기반 집합
      - `var.list.0`: 인덱스 0 참조
      - `for name in var.list`: 반복문
    - map: 값, 속성 기반 집합, 키값 기준 정렬
    - set: 값 기반, 키값 기준 정렬
    - object
    - tuple
- `validation` 블록: 0.13.0 버전부터 입력되는 변수 타입 외에 사용자 지정 유효성 검사가 가능
- `sensitive` 옵션: 변수의 민감 여부를 지정
  - 민감한 변수로 지정해도 `terraform.tfstate` 파일에는 평문으로 기록되므로 보안에 유의
- 우선순위
  1. `terraform plan` 실행 후 입력
  2. variable 블록의 `default` 값
  3. `TF_VAR_` 환경 변수
  4. `terraform.tfvars`에 정의된 변수
  5. `*.auto.tfvars`에 정의된 변수
  6. `*.auto.tfvars.json`에 정의된 변수
  7. `-var` 인수 또는 `-var-file`로 지정