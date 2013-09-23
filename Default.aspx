<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <style type="text/css">
        .ticTacToeBoard {
            text-align: center;
            font-size: 80px;
            font-family: 'Arial';
            font-weight: bold;
        }

            .ticTacToeBoard tr {
                vertical-align: middle;
                height: 100px;
            }

            .ticTacToeBoard td {
                width: 100px;
            }

        .won {
            background-color: rgba(0,0,0,0.3);
            position: absolute;
            width: 322px;
            height: 310px;
            font-size: 300px;
            font-family: 'Arial';
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            display: none;
        }
    </style>

    <script type="text/javascript">

        var data = [[ [['', '', ''], ['', '', ''], ['', '', '']], [['', '', ''], ['', '', ''], ['', '', '']],[['', '', ''], ['', '', ''], ['', '', '']]],[ [['', '', ''], ['', '', ''], ['', '', '']], [['', '', ''], ['', '', ''], ['', '', '']],[['', '', ''], ['', '', ''], ['', '', '']]],[ [['', '', ''], ['', '', ''], ['', '', '']], [['', '', ''], ['', '', ''], ['', '', '']],[['', '', ''], ['', '', ''], ['', '', '']]]]  ;
        var tData = [['', '', ''], ['', '', ''], ['', '', '']];
        var nt = '';

        var turn = false;
        var win = '';
        $(function () {
            drawGrid();
            //  $('#won1').hide();
            $('.ticTacToeBoard td').click(function (event) {
                
                var x = this.children[0].id.substring(4, 5);
                var y = this.children[0].id.substring(5, 6);
                var tx = this.children[0].id.substring(1, 2);
                var ty = this.children[0].id.substring(2, 3);
                // alert(x + ' - ' + y);
                
                if (data[tx - 1][ty - 1][x - 1][y - 1] == '' && (nt == '' || nt == (tx.toString() + ty.toString()))) {
                    nt = (x).toString() + (y).toString();
                    if (tData[x-1][y-1] != '') {
                        nt = '';
                    }
                    data[tx - 1][ty - 1][x - 1][y - 1] = turn ? 'X' : 'O';

                    turn = !turn;
                    
                    
                    detectWin();
                }
                drawGrid();
            });



        });

        function detectBigWin() {
            var bigWin=''
            for (var i = 0; i < 3; i++) {
                if (tData[i][0] == tData[i][1] && tData[i][1] == tData[i][2] && tData[i][0] != '')
                    bigWin = tData[i][0];
                else if (tData[0][i] == tData[1][i] && tData[1][i] == tData[2][i] && tData[0][i] != '')
                    bigWin = tData[0][i];
            }
            if (tData[0][0] == tData[1][1] && tData[1][1] == tData[2][2] && tData[1][1] != '')
                bigWin = tData[1][1];
            else if (tData[2][0] == tData[1][1] && tData[1][1] == tData[0][2] && tData[1][1] != '')
                bigWin = tData[1][1];

            if (bigWin != '') {
               // $('#won' + (tx + 1).toString() + (ty + 1).toString()).text(win);
                //$('#won' + (tx + 1).toString() + (ty + 1).toString()).css('display', 'inline');
                //tData[tx][ty] = win;
                alert(bigWin + ' wins');

            }

        }

        function detectWin() {
            // 8 ways to win

            for (var tx = 0; tx < 3; tx++) {
                for (var ty = 0; ty < 3; ty++) {
                    if (tData[tx][ty] == '') {
                        win = '';
                        for (var i = 0; i < 3; i++) {
                            if (data[tx][ty][i][0] == data[tx][ty][i][1] && data[tx][ty][i][1] == data[tx][ty][i][2] && data[tx][ty][i][0] != '')
                                win = data[tx][ty][i][0];
                            else if (data[tx][ty][0][i] == data[tx][ty][1][i] && data[tx][ty][1][i] == data[tx][ty][2][i] && data[tx][ty][0][i] != '')
                                win = data[tx][ty][0][i];
                        }
                        if (data[tx][ty][0][0] == data[tx][ty][1][1] && data[tx][ty][1][1] == data[tx][ty][2][2] && data[tx][ty][1][1] != '')
                            win = data[tx][ty][1][1];
                        else if (data[tx][ty][2][0] == data[tx][ty][1][1] && data[tx][ty][1][1] == data[tx][ty][0][2] && data[tx][ty][1][1] != '')
                            win = data[tx][ty][1][1];

                        if (win != '') {
                            $('#won' + (tx + 1).toString() + (ty + 1).toString()).text(win);
                            $('#won' + (tx + 1).toString() + (ty + 1).toString()).css('display', 'inline');
                            tData[tx][ty] = win;
                           // alert(win + ' wins');

                        }
                    }
                }
            }
            detectBigWin();
        }


        function drawGrid() {
            var x, y, tx, ty = 0;
            for (tx = 0; tx < 3; tx++) {
               
                for (ty = 0; ty < 3; ty++) {
                   // $('#T11').css('background-color', 'rgba(0,0,0,0.1)');
                    if (nt == '' || nt ==(   (tx + 1).toString() + (ty + 1).toString()))
                        $('#T' + (tx + 1).toString() + (ty + 1).toString()).css('background-color', 'white');
                    else
                        $('#T' + (tx + 1).toString() + (ty + 1).toString()).css('background-color', 'rgba(0,0,0,0.1)');

                        for (x = 0; x < 3; x++) {
                            for (y = 0; y < 3; y++) {
                                //  alert('#T1-' + x.toString() + y.toString());
                                $('#T' +(tx + 1).toString() + (ty + 1).toString() + '-' + (x + 1).toString() + (y + 1).toString()).text(data[tx][ty][x][y]);
                            }
                        }
                    
                }
            }
            $('.ticTacToeBoard').css('cursor', 'url(' + (turn ? 'X' : 'O') + '.png) 32 34, pointer');
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <div id="won11" class="won"></div>
                        <table id="T11" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T11-11"></span>

                                </td>
                                <td><span id="T11-12"></span></td>
                                <td><span id="T11-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T11-21"></span></td>
                                <td><span id="T11-22"></span></td>
                                <td><span id="T11-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T11-31"></span></td>
                                <td><span id="T11-32"></span></td>
                                <td><span id="T11-33"></span></td>
                            </tr>
                        </table>
                        

                    </td>
                    <td>
                        <div id="won12" class="won">
                        </div>
                        <table id="T12" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T12-11"></span>

                                </td>
                                <td><span id="T12-12"></span></td>
                                <td><span id="T12-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T12-21"></span></td>
                                <td><span id="T12-22"></span></td>
                                <td><span id="T12-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T12-31"></span></td>
                                <td><span id="T12-32"></span></td>
                                <td><span id="T12-33"></span></td>
                            </tr>
                        </table>
                        
                    </td>
                    <td>
                         <div id="won13" class="won">
                        </div>
                        <table id="T13" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T13-11"></span>

                                </td>
                                <td><span id="T13-12"></span></td>
                                <td><span id="T13-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T13-21"></span></td>
                                <td><span id="T13-22"></span></td>
                                <td><span id="T13-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T13-31"></span></td>
                                <td><span id="T13-32"></span></td>
                                <td><span id="T13-33"></span></td>
                            </tr>
                        </table>
                       
                    </td>
                </tr>

                <tr>
                    <td>
                        <div id="won21" class="won">
                        </div>
                        <table id="T21" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T21-11"></span>

                                </td>
                                <td><span id="T21-12"></span></td>
                                <td><span id="T21-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T21-21"></span></td>
                                <td><span id="T21-22"></span></td>
                                <td><span id="T21-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T21-31"></span></td>
                                <td><span id="T21-32"></span></td>
                                <td><span id="T21-33"></span></td>
                            </tr>
                        </table>
                        
                    </td>
                    <td>
                         <div id="won22" class="won">
                        </div>
                        <table id="T22" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T22-11"></span>

                                </td>
                                <td><span id="T22-12"></span></td>
                                <td><span id="T22-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T22-21"></span></td>
                                <td><span id="T22-22"></span></td>
                                <td><span id="T22-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T22-31"></span></td>
                                <td><span id="T22-32"></span></td>
                                <td><span id="T22-33"></span></td>
                            </tr>
                        </table>
                       
                    </td>
                    <td>
                        <div id="won23" class="won">
                        </div>
                        <table id="T23" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T23-11"></span>

                                </td>
                                <td><span id="T23-12"></span></td>
                                <td><span id="T23-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T23-21"></span></td>
                                <td><span id="T23-22"></span></td>
                                <td><span id="T23-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T23-31"></span></td>
                                <td><span id="T23-32"></span></td>
                                <td><span id="T23-33"></span></td>
                            </tr>
                        </table>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                         <div id="won31" class="won">
                        </div>
                        <table id="T31" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T31-11"></span>

                                </td>
                                <td><span id="T31-12"></span></td>
                                <td><span id="T31-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T31-21"></span></td>
                                <td><span id="T31-22"></span></td>
                                <td><span id="T31-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T31-31"></span></td>
                                <td><span id="T31-32"></span></td>
                                <td><span id="T31-33"></span></td>
                            </tr>
                        </table>
                        <div id="won31" class="won">
                        </div>
                    </td>
                    <td>
                         <div id="won32" class="won">
                        </div>
                        <table id="T32" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T32-11"></span>

                                </td>
                                <td><span id="T32-12"></span></td>
                                <td><span id="T32-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T32-21"></span></td>
                                <td><span id="T32-22"></span></td>
                                <td><span id="T32-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T32-31"></span></td>
                                <td><span id="T32-32"></span></td>
                                <td><span id="T32-33"></span></td>
                            </tr>
                        </table>
                       
                    </td>
                    <td>
                        <div id="won33" class="won">
                        </div>
                        <table id="T33" class="ticTacToeBoard" border="1">
                            <tr>
                                <td>
                                    <span id="T33-11"></span>

                                </td>
                                <td><span id="T33-12"></span></td>
                                <td><span id="T33-13"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T33-21"></span></td>
                                <td><span id="T33-22"></span></td>
                                <td><span id="T33-23"></span></td>
                            </tr>
                            <tr>
                                <td><span id="T33-31"></span></td>
                                <td><span id="T33-32"></span></td>
                                <td><span id="T33-33"></span></td>
                            </tr>
                        </table>
                        
                    </td>
                </tr>

            </table>





        </div>
    </form>
</body>
</html>
