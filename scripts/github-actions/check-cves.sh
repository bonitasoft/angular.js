curl --request GET -sL \
     --url 'https://security.snyk.io/package/npm/angular/1.3.20'\
     --output 'test.html'

NUMBER=$(grep -o -i '<li class="vue--severity__item vue--severity__item--high' test.html | wc -l)

# Main reason this might happen is if their page structure changed
if [ "$NUMBER" -lt 4 ];
  then
    echo "Error, there should be more CVEs"
    exit 1
fi

if [ "$NUMBER" -gt 4 ];
  then
    echo "More errors"
    exit 1
fi

echo "Same number of errors"
