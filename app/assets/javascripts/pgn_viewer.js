var PgnViewer = function(pgn) {

  var game, cfg, board, gameHistory, moveIndex;

  initGame();

  function initGame() {
    game = new Chess();

    cfg = {
      position: 'start',
      pieceTheme: "/assets/chesspieces/wikipedia/{piece}.png"
    };

    board = ChessBoard('board', cfg);

    loadPGN();
    setupButtons();
  }

  function loadPGN() {
    var pgn_loaded = game.load_pgn(pgn);
    gameHistory = game.history({verbose: true});
    moveIndex = 0;
    console.log("Pgn loaded?: " + pgn_loaded);
  }

  function setupButtons() {
    $('#startBtn').on('click', function() {
      board.start();
      resetGameHistory();
    });

    $('#backBtn').on('click', function() {
      if (!outOfBounds(moveIndex - 1)) {
        moveIndex--;
        board.move(getMove("back"));
      }
    });

    $('#fwdBtn').on('click', function() {
      if (!outOfBounds(moveIndex + 1)) {
        board.move(getMove("forward"));
        moveIndex++;
      }
    });
  }

  function outOfBounds(index) {
    return typeof gameHistory[index] === "undefined";
  }

  function getMove(str) {
    var move_from, move_to, move;

    if (str === "back") {
      move_from = gameHistory[moveIndex]["to"];
      move_to = gameHistory[moveIndex]["from"];
    } else if (str === "forward") {
      move_from = gameHistory[moveIndex]["from"];
      move_to = gameHistory[moveIndex]["to"];
    }

    move = move_from + "-" + move_to;

    console.log("Move: " + move);
    return move;
  }

  function resetGameHistory() {
    loadPGN();
  }
};