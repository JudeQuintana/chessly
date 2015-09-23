$(document).ready(function() {

  $('#example').on('click', function(e) {
    e.preventDefault();

    var exPGN = '[Event "Riga ;MAINB"]\n[Site "Riga ;MAINB"]\n[Date "1957.??.??"]\n[EventDate "?"]\n[Round "?"]\n[Result "1-0"]\n[White "Mikhail Tal"]\n[Black "Alexander Koblents"]\n\n1.e4 c5 2.Nf3 d6 3.d4 cxd4 4.Nxd4 Nf6 5.Nc3 Nc6 6.Bg5 {this is an inline comment followed by a variation} e6 (6... e5 7.Qd3 exd4) 7.Qd2 Be7 8.O-O-O O-O 9.Nb3 Qb6 10.f3 a6 11.g4 Rd8 12.Be3 Qc7 13.h4 b5 14.g5 Nd7 15.g6 hxg6 16.h5 gxh5 17.Rxh5 Nf6 18.Rh1 d5 19.e5 Nxe5 20.Bf4 Bd6 21.Qh2 Kf8 22.Qh8+ Ng8 23.Rh7 f5 24.Bh6 Rd7 25.Bxb5 Rf7 26.Rg1 Ra7 27.Nd4 Ng4 28.fxg4 Be5 29.Nc6 Bxc3 30.Be3 d4 31.Rgh1 Rd7 32.Bg5 axb5 33.R1h6 d3 34.bxc3 d2 35.Kd1 Qxc6 36.Rf6+ Rf7 37.Qxg7+ 1-0';

    var textArea = $('textarea');
    textArea.val(exPGN);
  })
});