curl --request GET -sL \
     --url 'https://security.snyk.io/package/npm/angular/1.3.20'\
     --output 'test.html'

EXPECTED_CVES=("vuln/SNYK-JS-ANGULAR-6091113" "vuln/SNYK-JS-ANGULAR-572020" "vuln/npm:angular:20150909" "vuln/npm:angular:20150807" "vuln/npm:angular:20150310")

# Find CVE links from the html file
mapfile -t FOUND_CVES < <(grep -oP -i '<li class="vue--severity__item vue--severity__item--high.*href="\K([^"]*)' test.html)

# Now compare arrays FOUND_CVES and EXPECTED_CVES

# Check all expected CVEs are here
for i in ${EXPECTED_CVES[@]}; do
    skip=
    for j in ${FOUND_CVES[@]}; do
        [[ $i == $j ]] && { skip=1; break; }
    done
	# Main reason this might happen is if their page structure changed
    if [ -z "$skip" ]
	then
		echo "========================================================================================="
		echo "Error, there should be more CVEs"
		echo "${i} was not found"
		echo "This might be because SNYK has changed their page"
		echo "Making '<li class='vue--severity__item vue--severity__item--high' un-findable in the page"
		echo "Visit https://security.snyk.io/package/npm/angular/1.3.20"
		echo "========================================================================================="

		exit 1
	fi
done

# Check no unexpected CVE is here
for i in ${FOUND_CVES[@]}; do
    skip=
    for j in ${EXPECTED_CVES[@]}; do
        [[ $i == $j ]] && { skip=1; break; }
    done
	# New CVE found
    if [ -z "$skip" ]
	then
		echo "=================================================="
		echo "Error, new CVEs are available for AngularJS 1.3.20"
		echo "${i} was found"
		echo "Visit https://security.snyk.io/package/npm/angular/1.3.20"
		echo "=================================================="

		exit 1
	fi
done

echo "Same old CVEs"
