resource "local_file" "abc" { # 파일을 프로비저닝
    content = "abc!"
    filename = "${path.module}/abc.txt" # 실행되는 테라폼 모듈의 파일 시스템 경로 -> chapter3/03.start/
}