$ ->
  ITEMS = []

  $("#checkout").hide()

  $("#flag").click ->
    addCheckouts "1"

  $("#car").click ->
    addCheckouts "2"

  $("#band").click ->
    addCheckouts "3"

  addCheckouts = (item) ->
    $("#checkout").show()
    ITEMS.push item
    $.ajax(
      url: "/checkout_baskets/calculations"
      type: "GET"
      data: { "items": ITEMS }
      dataType: "html"
      success: (data) ->
        $("#totalItems").text(ITEMS.length)
        $("#subTotal").text(data)
        $("#orders").val(ITEMS)
    )
