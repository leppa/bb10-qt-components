var items = [];
var pendingItems = [];

function push(component)
{
    var item = pageContainer.createObject(content);
    if (item == null)
        return null;

    var page = component.createObject(item);
    if (page == null) {
        console.log(component.errorString);
        item.destroy();
        return null;
    }

    item.page = page;
    items.push(item);
    update();

    return page;
}

function pop()
{
    if (items.length == 0)
        return false;

    var item = items.pop();
    pendingItems.push(item);
    update();

    return true;
}

function update()
{
    var index = items.length - 1;
    pageSlider.pageCount = items.length;

    if (index >= 0) {
        var page = items[index].page;
        page.visible = true;
        pageSlider.currentPage = page;
    } else {
        pageSlider.currentPage = null;
    }

    flickable.contentX = Math.max(0, index) * flickable.width;
}

function finalize()
{
    for (var i = 0; i < items.length; i++)
        items[i].page.visible = (i == items.length - 1);

    while (pendingItems.length > 0) {
        var item = pendingItems.pop();
        item.destroy();
    }
}
