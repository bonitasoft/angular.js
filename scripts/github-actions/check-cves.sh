curl --request GET -sL \
     --url 'https://security.snyk.io/package/npm/angular/1.3.20'\
     --output 'test.html'
EXPECTED_NUMBER=4
NUMBER=$(grep -o -i '<li class="vue--severity__item vue--severity__item--high' test.html | wc -l)

# Main reason this might happen is if their page structure changed
if [ "$NUMBER" -lt "$EXPECTED_NUMBER" ];
  then
    echo "========================================================================================="
    echo "Error, there should be more CVEs"
    echo "This might be because SNYK has changed their page"
    echo "Making '<li class='vue--severity__item vue--severity__item--high' un-findable in the page"
    echo "========================================================================================="

    exit 1
fi

if [ "$NUMBER" -gt "$EXPECTED_NUMBER" ];
  then
    echo "=================================================="
    echo "Error, new CVEs are available for AngularJS 1.3.20"
    echo "=================================================="

    exit 2
fi

echo "Same number of errors"
