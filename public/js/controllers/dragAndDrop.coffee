###
function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("Text", ev.target.id);
}

function drop(item, ev) {
    ev.preventDefault();
    var data = ev.dataTransfer.getData("Text");
    ev.target.appendChild(document.getElementById(data));
    alert(item.id);
}
###
allowDrop = (ev) ->
  ev.preventDefault()

drag = (ev) ->
  ev.dataTransfer.setData("Text" , ev.target.id)

drop = (item, ev) ->
  console.log(item.id)
  ev.preventDefault()
  data = ev.dataTransfer.getData("Text")
  ev.target.appendChild(document.getElementById(data));
