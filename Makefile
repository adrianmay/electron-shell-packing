TARGET=index.html
${TARGET}: elements go.awk script.js
	cat script.js > ${TARGET}
	awk -f go.awk < elements >> ${TARGET}

