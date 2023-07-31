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