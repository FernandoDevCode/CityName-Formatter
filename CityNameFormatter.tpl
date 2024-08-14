___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "CityNameFormatter",
  "description": "",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 14/08/2024, 13:56:50


