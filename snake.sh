
function snake_board () {
	local positions=( "$@" )

	echo "- - - - - - - - - - "
	echo  "|  ${positions[0]}  ${positions[1]}  ${positions[2]}  ${positions[3]}  ${positions[4]}  |"
	echo  "|  ${positions[5]}  ${positions[6]}  ${positions[7]}  ${positions[8]}  ${positions[9]}  |"
	echo  "|  ${positions[10]}  ${positions[11]}  ${positions[12]}  ${positions[13]}  ${positions[14]}  |"
	echo  "|  ${positions[15]}  ${positions[16]}  ${positions[17]}  ${positions[18]}  ${positions[19]}  |"
	echo  "|  ${positions[20]}  ${positions[21]}  ${positions[22]}  ${positions[23]}  ${positions[24]}  |"
	echo "- - - - - - - - - - "
}


position=( "o" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " )
attempt=0
level=1
score=0



function check_attempt () {
	local score=$1

	if [[ $attempt -gt 5 ]]
	then
		score=$(( $score + 5 ))
	else
		score=$(( $score + 10 ))
	fi
	echo "$score"
}


function find_current_position () {
	for i in `seq 0 1 24`
	do
		if [[ ${position[$i]} == "o" ]]
		then
			local current_position="$i"
		fi
	done
	echo "$current_position"
}


function run_snake () {
	local target=$( target )
	position[ $target ]="*"

	move_snake $target
}


function target () {
	local target=$( jot -r 1 0 24 )
	echo "$target"
}

function check_target () {
	local current_position=$1
	local target=$2

	if [[ $current_position == $target ]]
	then
		level=$(( $level + 1 ))
		score=$( check_attempt $score )
		attempt=0

		target=$( target )
		position[ $target ]="*"
	fi
		echo "level:$level"

	echo "score: $score points"

	if [[ $level -le 10 ]]
	then
		if [[ $score -ge 80 ]]
		then
			echo "You Won!!"
			exit
		fi
	else
		echo "You Lost !!"
		exit
	fi

	move_snake $target

}


function move_snake () {
	local target=$1
	snake_board "${position[@]}"
	current_position=$( find_current_position )
	read -p "enter your direction (lrud) :" direction
	clear

	attempt=$(( $attempt + 1 ))
	echo "attempt: $attempt"

	if [[ $direction == "l" ]]
	then
		left_move $current_position $target
	elif [[ $direction == "r" ]]
	then
		right_move $current_position $target
	elif [[ $direction == "u" ]]
	then
		up_move $current_position $target
	elif [[ $direction == "d" ]]
	then
		down_move $current_position $target
	else
		echo "invalid move"
		move_snake $target
	fi

}

function right_move () {
	local current_position=$1
	local target=$2
	if [[ $current_position == 4 ]] || [[ $current_position == 9 ]] || [[ $current_position == 14 ]] || [[ $current_position == 19 ]] || [[ $current_position == 24 ]]
	then
		echo "game over"
		exit
	fi
	position[ $current_position ]=" "

	current_position=$(( $current_position + 1 ))

	position[ $current_position ]="o"

	check_target $current_position $target

}

function left_move () {
	local current_position=$1
	local target=$2

	 if [[ $current_position == 0 ]] || [[ $current_position == 5 ]] || [[ $current_position == 10 ]] || [[ $current_position == 15 ]] || [[ $current_position == 20 ]]
	 then
	    echo "game over"
		exit
	fi

	position[ $current_position ]=" "

	current_position=$(( $current_position - 1 ))

	position[ $current_position ]="o"
	check_target $current_position $target
}

function up_move () {
	 local current_position=$1
	local target=$2

	 if [[ $current_position == 0 ]] || [[ $current_position == 1 ]] || [[ $current_position == 2 ]] || [[ $current_position == 3 ]] || [[ $current_position == 4 ]]
	 then
	    echo "game over"
		exit
	fi

	position[ $current_position ]=" "

	current_position=$(( $current_position - 5 ))

	position[ $current_position ]="o"
	check_target $current_position $target
}


function down_move () {
	local current_position=$1
	local target=$2

	 if [[ $current_position == 20 ]] || [[ $current_position == 21 ]] || [[ $current_position == 22 ]] || [[ $current_position == 23 ]] || [[ $current_position == 24 ]]
	 then
	    echo "game over"
		exit
	fi

	position[ $current_position ]=" "

	current_position=$(( $current_position + 5 ))

	position[ $current_position ]="o"
	check_target $current_position $target
}

