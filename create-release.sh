function init() {
    githubURL="https://github.com/rusun01/test-repository"

function getLatestRelease() {
    local releaseFound=$(curl -sb -H "Accept: application/json" $githubURL/releases/latest| jq -r '.tag_name')

    if [ $releaseFound != "null" ]; then
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

    local jsonBody="{ \"tag_name\": \"$nextRelease\", \"target_commitish\": \"master\", \"name\": \"$nextRelease\", \"body\": \"Making a new release. This version is $nextRelease\", \"draft\": false, \"prerelease\": false }"

    curl -X POST \
        $githubURL/releases \
        -H 'Content-Type: application/json' \
        -d "$jsonBody" \
        --fail
}