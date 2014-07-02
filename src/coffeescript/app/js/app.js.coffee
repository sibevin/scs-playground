ox_game_app = angular.module('oxGameApp', [])

ox_game_app.controller "oxGameCtrl", [
  '$scope'
  ($scope) ->

    BOARD_SIZE = 3

    round = 1

    $scope.player1_name = "Lalala"
    $scope.player2_name = "Wahaha"

    initGame = ->
      $scope.who_first = Math.floor((Math.random() * 100) + 1) % 2
      $scope.game_state = 'init'
      round = 1
      $scope.board_clicks = []
      for x in [0..(BOARD_SIZE - 1)]
        $scope.board_clicks[x] = []
        for y in [0..(BOARD_SIZE - 1)]
          $scope.board_clicks[x][y] = 0

    showWin = ->
      $scope.game_state = 'finish'

    showEven = ->
      $scope.game_state = 'even'

    $scope.startGame = () ->
      $scope.game_state = 'playing'

    $scope.resetGame = () ->
      $scope.game_state = 'init'
      initGame()

    $scope.blockClick = (x, y) ->
      return if $scope.board_clicks[x][y] != 0
      return if $scope.game_state != 'playing'
      $scope.board_clicks[x][y] = $scope.turnWho()
      if round >= (BOARD_SIZE * 2 - 1)
        if checkRowColLine(x, y)
          showWin()
          return
        if ((x == y) || (x + y == BOARD_SIZE - 1)) && checkDiagonalLine(x, y)
          showWin()
          return
      if round == (BOARD_SIZE * BOARD_SIZE)
        showEven()
        return
      round = round + 1

    $scope.turnWho = ->
      ($scope.who_first + round) % 2 + 1

    $scope.turnMark = ->
      (round % 2)

    $scope.getCurrentName = ->
      if $scope.turnWho() == 1
        return $scope.player1_name
      else
        return $scope.player2_name

    $scope.isSelected = (x, y, mark) ->

    $scope.getBlockBorderCss = (x, y) ->
      css_str = ""
      if x == 0
        css_str = " gp-block-top"
      if y == 0
        css_str = css_str + " gp-block-left"
      if x == (BOARD_SIZE - 1)
        css_str = css_str + " gp-block-bottom"
      if y == (BOARD_SIZE - 1)
        css_str = css_str + " gp-block-right"
      return css_str

    $scope.getPlayerColorCss = ->
      if $scope.turnWho() == 1
        return "gp-color-player1"
      else
        return "gp-color-player2"

    $scope.getMarkCss = (x, y = undefined) ->
      if y == undefined
        target = x
      else
        target = $scope.board_clicks[x][y]
      css_str = "gp-mark-"
      css_str = css_str + "o-" if target == (($scope.who_first + 1) % 2 + 1)
      css_str = css_str + "x-" if target == ($scope.who_first + 1)
      css_str = css_str + target
      return css_str

    checkRowColLine = (x, y) ->
      check_result = true
      for index in [0..(BOARD_SIZE - 1)]
        if $scope.board_clicks[x][index] != $scope.turnWho()
          check_result = false
          break
      return check_result if check_result
      check_result = true
      for index in [0..(BOARD_SIZE - 1)]
        if $scope.board_clicks[index][y] != $scope.turnWho()
          check_result = false
          break
      return check_result if check_result
      return false

    checkDiagonalLine = (x, y) ->
      if (x == y)
        check_result = true
        for index in [0..(BOARD_SIZE - 1)]
          if $scope.board_clicks[index][index] != $scope.turnWho()
            check_result = false
            break
        return check_result if check_result
      if (x + y == BOARD_SIZE - 1)
        check_result = true
        for index in [0..(BOARD_SIZE - 1)]
          if $scope.board_clicks[index][(BOARD_SIZE - 1 - index)] != $scope.turnWho()
            check_result = false
            break
        return check_result if check_result
      return false

    initGame()
]
