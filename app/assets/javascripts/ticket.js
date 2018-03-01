document.addEventListener('DOMContentLoaded', function () {
  var docElem = document.documentElement;
  var kanban = document.querySelector('.kanban-demo');
  var board = kanban.querySelector('.board');
  var itemContainers = Array.prototype.slice.call(kanban.querySelectorAll('.board-column-content'));
  var columnGrids = [];
  var dragCounter = 0;
  var boardGrid;
  var status;

  itemContainers.forEach(function (container) {
    var muuri = new Muuri(container, {
      items: '.board-item',
      layoutDuration: 400,
      layoutEasing: 'ease',
      dragEnabled: true,
      dragSortInterval: 0,
      dragSortGroup: 'column',
      dragSortWith: 'column',
      dragContainer: document.body,
      dragReleaseDuration: 400,
      dragReleaseEasing: 'ease'
    })
    .on('dragStart', function (item) {
      ++dragCounter;
      docElem.classList.add('dragging');
      item.getElement().style.width = item.getWidth() + 'px';
      item.getElement().style.height = item.getHeight() + 'px';
    })
    .on('dragEnd', function (item) {
      if (--dragCounter < 1) {
        docElem.classList.remove('dragging');
      }
    })
    .on('dragReleaseEnd', function (item) {
      item.getElement().style.width = '';
      item.getElement().style.height = '';
      columnGrids.forEach(function (muuri) {
        muuri.refreshItems();
      });
      //alert("this " + item._element.id + "in " + $("#" + item._element.id).parent().parent().attr('class').split(" ")[1])
      status = $("#" + item._element.id).parent().parent().children(".board-column-header").html();
      if (status == "New"){
        $.post('tickets/change_status_ticket/',{'id': item._element.id.split("_")[1], 'status_ticket': "New"})
      }else if (status == "On Progress"){
        $.post('tickets/change_status_ticket/',{'id': item._element.id.split("_")[1], 'status_ticket': "On Progress"})
      }else if (status == "Done"){
        $.post('tickets/change_status_ticket/',{'id': item._element.id.split("_")[1], 'status_ticket': "Done"})
      }
    })
    .on('layoutStart', function () {
      boardGrid.refreshItems().layout();
    });

    columnGrids.push(muuri);

  });

  boardGrid = new Muuri(board, {
    layoutDuration: 400,
    layoutEasing: 'ease',
    dragEnabled: true,
    dragSortInterval: 0,
    dragStartPredicate: {
      handle: '.board-column-header'
    },
    dragReleaseDuration: 400,
    dragReleaseEasing: 'ease'
  });
});