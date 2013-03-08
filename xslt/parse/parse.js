// Copyright &#169; 2012 Accenture - Prepared by Digiplug

var prevTog = null;
var tripleTog = [];
var countriesSelected = true;
var togStatus = {
  "resource": false,
  "release": false,
  "deal": false
};
var replaceLegendMap = {
  "AdvertisementSupportedModel": "Ad Funded",
  "PayAsYouGoModel": "A La Carte",
  "SubscriptionModel": "Subscription",
  "ConditionalDownload": "Time Limited",
  "PermanentDownload": "Permanent Download",
  "Stream": "Streaming",
  "FixedLine": "Online"
};
var togMap = {
  "soundtog": "sound",
  "vidtog": "vid",
  "imgtog": "img",
  "texttog": "txt",
  "reltog": "rel"
};


//box toggle
var tog = function() {
  for (var box in togMap) {
    if (togMap.hasOwnProperty(box)) {
      var pos = 1;
      $("div[id^=" + box + "]").each(function() {
        var elem = document.getElementById(togMap[box] + "-" + pos);
        elem.style.display = "none";
        $("#" + this.id).click(function() {
          $(elem).toggle("fast");
        });
        pos++;
      });
    }
  }
};

//country toggle
var tog2 = function(cat, trig, div) {
  var n = 1;
  var off = 1;
  var parent = 'div[id^="' + cat + '"]';
  var node = 'h4[id^="' + trig + '"]';
  $(parent).each(function() {
    $(node).each(function() {
      var target = "#" + div + "-" + off + "-" + n;
      $(target).hide();
      $("#" + trig + "-" + off + "-" + n).click(function() {
        $(target).toggle("fast");
      });
      n++;
    });
    n = 1;
    off++;
  });
};

//update frame on toggle
var update = function(id) {
  $.each(tripleTog, function(index, value) {
    $("#" + value).css("border", "1px solid #FFFFFF");
  });
  tripleTog.pop();tripleTog.pop();tripleTog.pop();
  if (prevTog != null && prevTog != id) {
    $("#" + prevTog).css("border", "1px solid #FFFFFF");
  }
  prevTog = id;
  $("#" + prevTog).css("border", "1px solid #FF6633");
};

// filtering helper
var filter = function(box) {
  var boxes = 'div[class="' + box.value + '"]';
  $(boxes).each(function() {
    var st = $(this).attr('style');
    if (st != 'display: block') {
      $(this).attr('style', 'display: block');
    } else {
      $(this).attr('style', 'display: none');
    }
  });
};

//link from summary to rows
var tripleLink = function(elem) {
  var resourceBox = $($('a[name="' + getLink(elem) + '"]').parent().parent()).attr("id");
  var releaseBox = $($('div[name="' + getLink(elem) + '"]').parent()).attr("id");
  var dealBox = $($('div[name="' + elem.attributes[1].value + '"]').parent()).attr("id");
  if (prevTog != null) {
    $("#" + prevTog).css("border", "1px solid #FFFFFF");
  }
  $.each(tripleTog, function(index, value) {
    $("#" + value).css("border", "1px solid #FFFFFF");
  });
  tripleTog.length = 0;
  tripleTog.push(resourceBox, releaseBox, dealBox);
  $.each(tripleTog, function(index, value) {
    $("#" + value).css("border", "1px solid #FF6633");
  });
  window.location.hash = "release" + elem.href.substring(elem.href.indexOf("#") + 1, elem.href.length);
  window.location.hash = "deal" + elem.attributes[1].value;
};

//close all rows
var collapseAll = function() {
  $('span[name]').each(function() {
    collapse(this);
  });
};

// close one row
var collapse = function(elem) {
  var prop = ['blocks', 'terr'];
  var n = $(elem).attr('name');
  if (togStatus[n] == true) {
    prop.reverse();
  }
  $.each(prop, function(idx, val) {
    if ($(elem).attr(val) != undefined) {
      expand($(elem).attr(val).split(','), togStatus[n]);
    }
  });
  togStatus[n] = !togStatus[n];
};

// use DSC tags instead of DDEX tags
var dscLegend = function() {
  $('div[id^=dealter] b span').each(function() {
    $(this).append('<br/><span class="legend">(' + bulkReplacer(replaceLegendMap)($(this).text()) + ')</span>');
  });
};

// helper to mass replace tags
var bulkReplacer = function(map) {
  var parts = [];
  for (var prop in map) {
    if (map.hasOwnProperty(prop)) {
      parts.push(prop);
    }
  }
  var regexp = new RegExp(parts.join("|"), "g");
  var sub = function(match) {
    return map[match];
  };
  return function(text) {
    return text.sub(regexp, sub);
  };
}

// toggle helper
var expand = function(target, status) {
  $.each(target, function(index, value) {
    var node = 'div[id^="' + value + '-"]';
    $(node).each(function() {
      if (status == false) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });
};

// pick from country list
var countryToggle = function() {
  $(":checkbox").each(function() {
    filter($(this).get(0));
    $(this).attr('checked', !countriesSelected);
  });
  countriesSelected = !countriesSelected;
};

// extract url
var getLink = function(elem) {
  var ref = $(elem).attr("href");
  return ref.substring(1, ref.length);
};

var initXSLT = function() {
  // here we need to hide the upload div, and remove previous results
  var e = document.getElementById("fileAlt");
  e.addEventListener("click", function(data) {
    e.style.display = "none";
    document.getElementById("fileUploader").style.display = "block";
    document.getElementById("xmlContent").innerHTML = '';
  }, false);

  var bench = new Date().getTime();
  tog();

  tog2("sound", "stertog", "ster");
  tog2("vid", "vtertog", "vter");
  tog2("img", "itertog", "iter");
  tog2("text", "ttertog", "tter");
  tog2("relter", "reltertog", "relter");
  tog2("dealter", "dealtertog", "dealter");
  var res = new Date().getTime() - bench;
  console.log("rendering took " + res + " ms.");

  $(".clickme").mouseenter(function() {
    $(this).removeClass('clickme').addClass('clickmeover');
  }).mouseleave(function() {
    $(this).removeClass('clickmeover').addClass('clickme');
  });

  $(".gotodeal").click(function() {
    update($($('a[name="' + getLink(this) + '"]').parent()).attr("id"));
  });

  $(".gotorel").click(function() {
    update($($('a[name="' + getLink(this) + '"]').parent().parent()).attr("id"));
  });

  $(':checkbox').each(function() {
    filter(this);
  });

  dscLegend();
};

function Init() {
  var fileselect = document.getElementById("fileselect"),
      filedrag = document.getElementById("filedrag");
  // file select
  fileselect.addEventListener("change", FileSelectHandler, false);
  // is XHR2 available?
  var xhr = new XMLHttpRequest();
  if (xhr.upload) {
    // file drop
    filedrag.addEventListener("dragover", FileDragHover, false);
    filedrag.addEventListener("dragleave", FileDragHover, false);
    filedrag.addEventListener("drop", FileSelectHandler, false);
    filedrag.style.display = "block";
    // remove submit button
  }
}

// file drag hover
function FileDragHover(e) {
  e.stopPropagation();
  e.preventDefault();
  e.target.className = (e.type == "dragover" ? "hover" : "");
}

// file selection
function FileSelectHandler(e) {
  // cancel event and hover styling
  FileDragHover(e);
  // fetch FileList object
  var files = e.target.files || e.dataTransfer.files;
  // process all File objects
  processXmlFile(files[0]);
}

function loadRemoteFile(dname)
{
  if (window.XMLHttpRequest)
  {
    xhttp=new XMLHttpRequest();
  }
  else
  {
    xhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  xhttp.open("GET",dname,false);
  xhttp.send("");
  return xhttp.responseXML;
}

function stringToDom(text)
{
  if (window.DOMParser)
  {
    parser=new DOMParser();
    xmlDoc=parser.parseFromString(text,"text/xml");
    return xmlDoc;
  }
  else // Internet Explorer
  {
    xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async=false;
    xmlDoc.loadXML(text);
    return xmlDoc;
  }
}

function processXmlFile(file) {
  var xmlContent = document.getElementById("xmlContent");
  var errorContent = document.getElementById("error");
  xmlContent.innerHTML = "";
  errorContent.innerHTML = "";

  var size = file.size / 1000000;
  if (size >= 3.5 && !confirm("File will take a while to process, continue ?")) {
      return;
  }

  if (file.type.indexOf("text/xml") == 0) {
    var reader = new FileReader();
    reader.onloadend = function(evt) {
      xsl=loadRemoteFile('parse.xsl');
      xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl);
      xmlDom = stringToDom(evt.target.result);
      var t_start = new Date().getTime();
      resultDocument = xsltProcessor.transformToFragment(xmlDom, document);
      document.getElementById("xmlContent").appendChild(resultDocument);
      document.getElementById("fileUploader").style.display = "none";
      document.getElementById("fileAlt").style.display = "block";
      initXSLT();
    }
    reader.readAsText(file);
  }
  else
  {
    errorContent.innerHTML = "The file " + file.name + " is not an XML ";
    if (file.type != null && file.type != "")
    {
      errorContent.innerHTML = errorContent.innerHTML + "(type: " + file.type + ")";
    }
  }
}

// call initialization file
if (window.File && window.FileList && window.FileReader && window.XMLHttpRequest) {
  Init();
}
else
{
  var m = document.getElementById("error");
  m.innerHTML = "Loading error: Your browser does not support some required HTML5 features. Please use a recent version of either Mozilla Firefox, Google Chrome or Opera.";
  document.getElementById('fileChooser').style.display = "none";
}

