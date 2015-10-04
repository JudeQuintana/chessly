var PgnViewer = function(pgn){

  var game = new Chess();

  pgn_loaded = game.load_pgn(pgn);

  console.log("Pgn loaded?: " + pgn_loaded);

  var cfg = {
    position: 'start',
    pieceTheme: "/assets/chesspieces/wikipedia/{piece}.png"
  };

  var board = ChessBoard('board', cfg);

  $('#startPositionBtn').on('click', board.start);

  $('#back').on('click', function() {
    board.move('e2-e4');
    console.log("back");
  });

  $('#forward').on('click', function() {
    console.log("foward");

    board.move('d2-d4', 'g8-f6');
  });
};