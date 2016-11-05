var myBIUS = function()
{
    document.getElementById("boldButtom").addEventListener("click", function (event2)
    {
        var text = document.getElementById("myText");
        text.value = text.value.substring(0, text.selectionStart) +
        '[b]'+text.value.substring(text.selectionStart, text.selectionEnd) +
        '[/b]'+text.value.substring(text.selectionEnd);
    });
        
    document.getElementById("italicButtom").addEventListener("click", function (event2)
    {
        var text = document.getElementById("myText");
        text.value = text.value.substring(0, text.selectionStart) +
        '[i]'+text.value.substring(text.selectionStart, text.selectionEnd) +
        '[/i]'+text.value.substring(text.selectionEnd);
    });
        
    document.getElementById("underlineButtom").addEventListener("click", function (event2)
    {
        var text = document.getElementById("myText");
        text.value = text.value.substring(0, text.selectionStart) +
        '[u]'+text.value.substring(text.selectionStart, text.selectionEnd) +
        '[/u]'+text.value.substring(text.selectionEnd);
    });
      
    document.getElementById("strikethroughButtom").addEventListener("click", function (event2)
    {
        var text = document.getElementById("myText");
        text.value = text.value.substring(0, text.selectionStart) +
        '[s]'+text.value.substring(text.selectionStart, text.selectionEnd) +
        '[/s]'+text.value.substring(text.selectionEnd);
    });
}

window.addEventListener("load", function (event)
{
    myBIUS();
    document.addEventListener("turbolinks:load", function (event)
    {
        myBIUS();
    });
});