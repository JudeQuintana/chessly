var PgnViewer = function(pgn) {

  var game, cfg, board, gameHistory, nextMove, lastMove;
  var moveIndex = 0;

  initGame();
  loadPGN();
  setupButtons();

  function initGame() {
    game = new Chess();

    cfg = {
      position: 'start',
      pieceTheme: "/assets/chesspieces/wikipedia/{piece}.png"
    };

    board = ChessBoard('board', cfg);
  }

  function loadPGN() {
    var pgn_loaded = game.load_pgn(pgn);

    gameHistory = game.history({verbose: true});
    console.log("Pgn loaded?: " + pgn_loaded);

    setNextMove();
    //console.log(gameHistory);
  }

  function setupButtons() {

    $('#startBtn').on('click', function(){
      board.start();
      resetGameHistory();
      setNextMove();
    });

    $('#backBtn').on('click', function() {
      console.log("lastMove: " + lastMove);
      board.move(lastMove);
    });

    $('#fwdBtn').on('click', function() {
      console.log("nextMove: " + nextMove);

      board.move(nextMove);

      setNextMove();
      setLastMove();
    });
  }

  function setNextMove() {
    var move_from = gameHistory[moveIndex]["from"];
    var move_to = gameHistory[moveIndex]["to"];

    nextMove = move_from + "-" + move_to;
    moveIndex++;
  }

  function setLastMove()
  {

  }

  function resetGameHistory(){
    gameHistory = game.history({verbose: true});
    moveIndex = 0;
  }
};