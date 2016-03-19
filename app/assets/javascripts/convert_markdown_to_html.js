"use strict";

var GlobalM2H = {};

GlobalM2H.commonmark = window.commonmark;
GlobalM2H.writer = new commonmark.HtmlRenderer({ sourcepos: true });
GlobalM2H.reader = new commonmark.Parser();

GlobalM2H.defaultOutputArea = $("#posts-preview");

GlobalM2H.convertMarkdownToHtml = function(inputText, outputAreaName){

    // outputArea is div
    var outputArea = outputAreaName ? $(outputAreaName) : GlobalM2H.defaultOutputArea;
    var parsed = GlobalM2H.reader.parse(inputText);

    outputArea.html(GlobalM2H.writer.render(parsed));

    // Syntax Highlight (Use "highlight.js")
    $('pre code').each(function(i, block) {
        hljs.highlightBlock(block);
    });

    MathJax.Hub.Typeset(["Typeset",MathJax.Hub, outputAreaName]);
}
