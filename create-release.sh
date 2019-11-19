function init() {
    githubURL="https://api.github.com/repos/rusun01/test-repository"
}

function getLatestRelease() {
    local releaseFound=$(curl -sb -H "Accept: application/json" $githubURL/releases/latest | jq -r '.tag_name')
    echo $releaseFound
    if [ $releaseFound != 'null' ]; then
        local latestRelease=$releaseFound
    else
        local latestRelease=0
    fi

    echo $latestRelease
}

function getNextRelease() {
    local currentRelease=$1
    local nextRelease=$(($currentRelease + 1))
    echo $nextRelease
}

function makeNewRelease() {
    local nextRelease=$1
    echo "Making release: $nextRelease"

    local jsonBody="{ \"tag_name\": \"$nextRelease\", \"target_commit_is \": \"master\", \"name\": \"$nextRelease\", \"body\": \"Making a new release. This version is $nextRelease\", \"draft\": false, \"prerelease\": false }"
    
    echo $jsonBody
    echo $githubURL

    local upload_url=$(curl -s -H -d '{"tag_name": \"$nextRelease\", \"target_commit_is \": \"master\",\"name\": \"$nextRelease\",\"body\": \"Making a new release. This version is $nextRelease\", \"draft\": false, \"prerelease\": false}'  \
     "$githubURL/releases" | jq -r '.upload_url')
   
    upload_url="${upload_url%\{*}"
    echo "uploading asset to release to url : $upload_url"
}

    # curl -s -H "Authorization: token $token"  \
    #         -H "Content-Type: application/zip" \
    #         --data-binary @test.zip  \
    #         "$upload_url?name=test.zip&label=some-binary.zip" 

    # curl -X POST \
    #     $githubURL/releases \
    #     -H 'Content-Type: application/json' \
    #     -d "$jsonBody" \
    #     --fail
# }