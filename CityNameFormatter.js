const getRequestHeader = require('getRequestHeader');
const logToConsole = require('logToConsole');

let cityName = getRequestHeader('X-Geo-City');
logToConsole("Original cityName: " + cityName); // Log before replacement

if (cityName) {
    let result = '';
    for (let i = 0; i < cityName.length; i++) {
        const current = cityName.charAt(i);
        const next = i + 1 < cityName.length ? cityName.charAt(i + 1) : '';
        const pair = current + next;

        if (pair === 'Ã£' || pair === 'Ã¡' || pair === 'Ã ' || pair === 'Ã¢') {
            result += 'a';
            i++; // Skip next character
        } else if (pair === 'Ã©' || pair === 'Ãª') {
            result += 'e';
            i++; // Skip next character
        } else if (pair === 'Ã­') {
            result += 'i';
            i++; // Skip next character
        } else if (pair === 'Ã³' || pair === 'Ã´' || pair === 'Ãµ') {
            result += 'o';
            i++; // Skip next character
        } else if (pair === 'Ãº' || pair === 'Ã¼') {
            result += 'u';
            i++; // Skip next character
        } else if (pair === 'Ã§') {
            result += 'c';
            i++; // Skip next character
        } else if (current !== ' ') { // Check if the current character is not a space
            result += current;
        }
        // If it is a space, do nothing (effectively removing it)
    }

    cityName = result.toLowerCase(); // Lowercase result
    logToConsole("Processed cityName: " + cityName); // Log after replacement
    return cityName;
}

data.gtmOnSuccess(); // In GTM, end with this call