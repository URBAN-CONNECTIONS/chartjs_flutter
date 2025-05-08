window.parent.addEventListener("message", handleMessage, false);

function handleMessage(e) {
  const message = e.data;
  const source = message.source;

  const windowId = window.frameElement?.id;

  if (source != windowId) {
    return;
  }

  switch (message["event"]) {
    case "createChart":
      _createChart(message);
      break;
  }
}

function postMessageChannel(message) {
  window.parent.postMessage({
    ...message,
  });
}


function _createChart(message) {
  const myChart = new Chart(document.getElementById("myChart"), message["data"]);
}
