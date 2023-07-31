# Chapter1
## IaC 도입의 긍정적인 측면
- 속도와 효율성: 사람이 수동으로 작업할 때보다 빠르고, 불필요한 인프라 구성을 방지하여 생산성을 높인다. 또한 코드를 변경하여 적용하면 인프라도 변경되어 기존 방식보다 변경 속도가 빠르다.
- 버전 관리: 코드 형태로 관리하기 때문에 버전 관리 툴(VCS)와 연계할 수 있다. 변경 내용을 추적하고 이전 코드로 되돌리거나 비교할 수 있다.
- 협업: 파일 형태로 되어 있어 쉽게 공유할 수 있고, 버전 관리 툴과 연계하면 공동 작업을 위한 환경을 만들 수 있다.
- 재사용성: 코드의 주요 반복 또는 표준화된 구성을 패키징하면 매번 새로 코드를 구성하지 않고 기존 모듈을 활용해 배포할 수 있다.
- 기술의 자산화: 관리 노하우와 작업 방식이 코드에 녹아 있고, 파이프라인에 통합해 워크플로 형태로 자산화되어 기술 부채를 제거한다.

## 테라폼의 세가지 철학
- 워크플로(workflow): 인프라 구성과 배포, 보안 구성이나 계정 추가 작업 또는 모니터링 도구 설정 등 이러한 작업들을 워크플로의 대상이라고 보고 어떤 구성이라도 환경의 변화에 크게 구애받지 않도록 설계하기 위한 워크플로를 설계
- 코드형 인프라(Infrastructure as Code): 구현되거나 구성되는 모든 것이 코드로 표현되어야 함
- 실용주의(pragmatism): 새로운 아이디어와 접근 방식, 기술을 다시 평가하고 이전의 것이 틀릴 수 있다는 사실을 받아들이는 적용 능력이 필요

## 테라폼 제공 유형
- On-premise: 일반적인 형태, 사용자의 컴퓨팅 환경에 설치하여 사용
- Cloud: `Hosted SaaS`의 일종으로, 하시코프가 관리하는 서버 환경이 제공
- Enterprise: `Private`한 환경, 사내 네트워크와 같은 환경에서 가능하고, 외부 네트워크와 격리됨