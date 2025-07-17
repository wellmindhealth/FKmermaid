const pako = require('pako');
const fs = require('fs');
const { Buffer } = require('buffer');

// Read from stdin instead of a file
const getStdin = require('get-stdin').default;

getStdin().then(data => {
    const mermaidCode = data;

    const json = {
        code: mermaidCode,
        mermaid: {
            theme: "default"
        }
    };

    const jsonStr = JSON.stringify(json);
    const compressed = pako.deflate(jsonStr, { level: 9 });
    const encoded = Buffer.from(compressed).toString('base64');
    const url = `https://mermaid.live/edit#pako:${encoded}`;

    console.log(url);
}); 