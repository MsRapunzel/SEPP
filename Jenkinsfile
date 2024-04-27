pipeline {
    agent any
    options {
        //ansiColor('xterm') // Добавляем цвет в логи, активируется через https://github.com/jenkinsci/ansicolor-plugin
        timeout(time: 8, unit: 'HOURS') // Устанавливаем ограничение времени ожидания окончания сборок
        disableConcurrentBuilds(abortPrevious: true) // Отменяем предыдущую сборку при поступлении новых коммитов в ту же ветку
    }
    // environment {
    //     // Здесь настраиваем все наши секреты (также известные как учетные данные), например, ключи API для fastlane, danger и т.д.
    //     APP_STORE_CONNECT_API_KEY_ISSUER_ID = credentials('APP_STORE_CONNECT_API_KEY_ISSUER_ID')
    //     APP_STORE_CONNECT_API_KEY_KEY = credentials('APP_STORE_CONNECT_API_KEY_KEY')
    //     APP_STORE_CONNECT_API_KEY_KEY_ID = credentials('APP_STORE_CONNECT_API_KEY_KEY_ID')
    //     DANGER_GITHUB_API_TOKEN = credentials('DANGER_GITHUB_API_TOKEN')
    //     MATCH_PASSWORD = credentials('MATCH_PASSWORD')
    //     // …и т.д.
    // }
    stages {
        stage("1. Set Up") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'MsRapunzel_github_app', usernameVariable: 'GITHUB_APP_USERNAME_TOKEN', passwordVariable: 'GITHUB_APP_PASSWORD_TOKEN')]) {
                    sh '''
                    source ~/.zshrc # Необходимо запустить, чтобы настроить правильную переменную окружения PATH, инициализировать rbenv и все остальное, что мы настроили ранее в файле ~/.zshrc

                    # Ссылки: https://git-scm.com/docs/gitcredentials#_custom_helpers и https://stackoverflow.com/q/61146986/4075379
                    git config credential.username ${GITHUB_APP_USERNAME_TOKEN}
                    git config credential.helper "!echo password=${GITHUB_APP_PASSWORD_TOKEN}; echo"

                    # С этого момента вы можете добавлять сюда свои скрипты, например, make, bundle install, pod install, xcodebuild build, test и т.д.
                    make
                    '''
                }
            }
        }
        stage("2. Static Code Analysis") {
            steps {
                sh '''
                source ~/.zshrc # Да, к сожалению, вам нужно запускать это каждый раз, когда вы объявляете новый "sh" shell-скрипт в ваш Jenkinsfile.
                bundle exec rake danger
                '''
            }
        }
        stage("3. Build & Distribute") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'MsRapunzel_github_app', usernameVariable: 'GITHUB_APP_USERNAME_TOKEN', passwordVariable: 'GITHUB_APP_PASSWORD_TOKEN')]) {
                    sh '''
                    source ~/.zshrc
                    bundle exec fastlane archive_and_distribute # Это действие требует прямого доступа к переменным среды GITHUB_APP_USERNAME_TOKEN и GITHUB_APP_PASSWORD_TOKEN
                    '''
                }
            }
        }
    }
    post {
        // Всегда очищайте рабочее пространство после того, как закончите его использовать, иначе после нескольких сборок вы забьете диск, и ваша машина, скорее всего, заглохнет.
        always {
            cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
        }
    }
}