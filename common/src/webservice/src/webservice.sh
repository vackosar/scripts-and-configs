#!/bin/sh
set -e
#set -x
wget \
	--post-file="in/request.xml" \
	--header="Content-Type: text/xml; charset=utf-8" \
	--header="SOAPAction: \"http://www.webserviceX.NET/GetCurrentMortgageIndexByWeekly\"" \
	--output-document=out/response.xml \
	http://www.webservicex.net/MortgageIndex.asmx
