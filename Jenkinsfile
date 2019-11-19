pipeline{
    agent any
    stages{
        stage('create release'){
            steps{
                script{
                    env.nextRelease = sh script: ''' #!/bin/bash
                        source create-release.sh
                        githubURL = 'https://github.com/rusun01/test-repository'
                        getNextRelease $(getLatestRelease)
                    ''', return Stdout: true

                    sh """#!/bin/bash
                        source create-release.sh
                        githubURL = 'https://github.com/rusun01/test-repository'
                        makeNewRelease %{env.nextRelease}
                    """
                }

            }
        }
    }
}