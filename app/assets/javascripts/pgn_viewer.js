var PgnViewer = function(pgn, fens_endpoint) {

  var game, cfg, board, gameHistory, moveIndex, fenIndex, fens;

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
    fenIndex = 0;
    console.log("Pgn loaded?: " + pgn_loaded);
    console.log("Pgn: " + pgn);
    $.getJSON(fens_endpoint, function(data){
      fens = data
    });
    $('#fen').append(document.createTextNode(""));
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
        fenIndex++;

        console.log("Fen: " + getFen(moveIndex));

        $('#fen').contents().last()[0].textContent=getFen(moveIndex);
      }
    });
  }

  function outOfBounds(index) {
    return typeof gameHistory[index] === "undefined";
  }

  function getFen(moveIndex){
    return fens[moveIndex-1];
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
