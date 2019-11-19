pipeline{
    agent any
    stages{
        stage('create release'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/rusun01/test-repository']]])
                script{
                    sh 'ls -la'
                    env.nextRelease = sh script: ''' #!/bin/bash
                        source ./create-release.sh
                        getNextRelease ${getLatestRelease}
                    ''', returnStdout: true

                    sh """#!/bin/bash
                        source ./create-release.sh
                        makeNewRelease %{env.nextRelease}
                    """
                }

            }
        }
    }
}