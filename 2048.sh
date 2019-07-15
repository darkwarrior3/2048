#!/bin/bash
#initialize vars/grid
g00=O
g01=O
g02=O
g03=O
g10=O
g11=O
g12=O
g13=O
g20=O
g21=O
g22=O
g23=O
g30=O
g31=O
g32=O
g33=O
ch="-"
#get first 2 numbers for the grid
for z in {0..1}; do
    rand1=$(($RANDOM % 4))
    rand2=$(($RANDOM % 4))
    rand3=$((2*(($RANDOM % 2)+1)))
    n="g${rand1}$rand2"
    eval ${n}=$rand3
done
#prints the board and caclualtes the moves
while true;do
    xyz=0
    clear
    for z in {0..3};do
        for y in {0..3};do
            var='g'$z$y
            v=${!var}
            if [ ${#v} -gt 1 ] && ! [[ $v =~ ^O+$ ]];then 
                eval $var=${v//O/}
            fi
        done
    done
    #clear
    echo ""
    figlet -t -c -f pagga 2048
    figlet -t -c -f pagga $ch #Header/Control
    inp=0
    #to make grid size uniform
    for x in {0..3}; do
        v1='g0'$x #var
        v2='g1'$x
        v3='g2'$x
        v4='g3'$x
        n1=${!v1} #value of var
        n2=${!v2}
        n3=${!v3}
        n4=${!v4}
        n1=${#n1} #length of var
        n2=${#n2}
        n3=${#n3}
        n4=${#n4}
        if [ ${n1} -gt ${n2} ] 2>/dev/null;then
            if [ ${n3} -gt ${n4} ] 2>/dev/null;then
                if [ ${n1} -gt ${n3} ] 2>/dev/null;then #Var1
                    v=$n1
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                else #Var3
                    v=$n3
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                fi
            else
                if [ ${n1} -gt ${n4} ] 2>/dev/null;then #Var1
                    v=$n1
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                else #Var4
                    v=$n4
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                fi
            fi
        else
            if [ ${n3} -gt ${n4} ] 2>/dev/null;then
                if [ ${n2} -gt ${n3} ] 2>/dev/null;then #Var2
                    v=$n2
                    v=$n2
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                else #Var3
                    v=$n3
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                fi
            else
                if [ ${n2} -gt ${n4} ] 2>/dev/null;then #Var2
                    v=$n2
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                else #Var4
                    v=$n4
                    for m in $(seq 1 4); do
                        n=v$m
                        len=${!n}
                        len=${!len}
                        len=${#len}
                        len2=${#v}
                        len=$(($v-$len))
                        until [ $len -eq 0 ];do
                            n=${!n}
                            eval ${n}=O${!n}
                            let len--
                        done
                    done
                fi
            fi
        fi
        v1=g$x'0'
        v2=g$x'1'
        v3=g$x'2'
        v4=g$x'3'
        var='| '${!v1}' | '${!v2}' | '${!v3}' | '${!v4}' | '
        #prints the grid
        figlet -t -f future ${var}
    done
    #get user input to move the board/only accepts WASD keys
    until [[ $inp =~ [WwAaSsDdUu] ]];do
        echo "W-Up;A-Left;S-Down;D-Right;U-Undo"
        read -n1 inp
    done
    #check the input and set directions and biases accordingly
    case $inp in
        [Ww]) #up
            stat=0
            bias='^\g0.?$'
            direction='-y'
            ch='/\'
            ;;
        [Ss]) #down
            stat=1
            bias='^\g3.?$'
            direction='+y'
            ch='\/'
            ;;
        [dD]) #right
            stat=1
            bias='^\g.?3$'
            direction='+x'
            ch='>'
            ;;
        [Aa]) #left
            stat=0
            bias='^\g.?0$'
            direction='-x'
            ch='<'
            ;;
        [Uu]) #undo
            xyz=1
            for x in {0..3}; do
                for y in {0..3}; do
                    eval 'g'$x$y='$n'$x$y
                done
            done
            ch=Undo
            ;;
        *)
            ;;
    esac
    if [ $xyz -ne 1 ]
    then
            for x in {0..3}; do
                for y in {0..3}; do
                    eval 'n'$x$y='$g'$x$y
                done
            done
        oper1=0
        oper2=0
        case $direction in
            +y)
                let oper1+=1
                ;;
            -y)
                let oper1-=1
                ;;
            +x)
                let oper2+=1
                ;;
            -x)
                let oper2-=1
                ;;
        esac
        for x in {0..3}; do
            if [ $stat -eq 1 ]; then #if negative direction then execute from +ve --> -ve
                for i in {0..3};do
                    for n in {0..3};do
                        var='g'${i}${n} #var to check
                        var2='g'$((${i}+$oper1))$((${n}+$oper2)) #var next to var in the specified direction
                        if ! [[ $var =~ $bias ]]; then
                            var3=${!var} #value of var
                            var4=${!var2} #value of var2
                            if [[ ${!var} =~ ^O+$ ]] && [[ ${!var2} =~ ^O+$ ]]; then #if both equal to 0
                                [ 1 -eq 1 ]
                            elif [[ ${!var} =~ O*.+ ]] && [[ ${!var2} =~ ^O+$ ]]; then #if one equal tp 0
                                eval $var2=${var3//O/}
                                eval $var=O
                            elif [[ ${var3//O/} == ${var4//O/} ]]; then #if both equal
                                eval $var=O
                                eval let $var2=2*${var4//O/}
                            fi
                        fi
                    done
                done
            else #if +ve direction then execute from -ve --> +ve
                for i in {3..0};do
                    for n in {3..0};do
                        var='g'${i}${n} #var to check
                        var2='g'$((${i}+$oper1))$((${n}+$oper2)) #var next to var in the specified direction
                        if ! [[ $var =~ $bias ]]; then
                            var3=${!var} #value of var
                            var4=${!var2} #value of var2
                            if [[ ${!var} =~ ^O+$ ]] && [[ ${!var2} =~ ^O+$ ]]; then #if both equal to 0
                                [ 1 -eq 1 ]
                            elif [[ ${!var} =~ O*.+ ]] && [[ ${!var2} =~ ^O+$ ]]; then #if one equal tp 0
                                eval $var2=${var3//O/}
                                eval $var=O
                            elif [[ ${var3//O/} == ${var4//O/} ]]; then #if both equal
                                eval $var=O
                                eval let $var2=2*${var4//O/}
                            fi
                        fi
                    done
                done
            fi
        done
        #get an new number for the grid every move
        loop=1
        while [ $loop -eq 1 ]; do
            rand1=$(($RANDOM % 4))
            rand2=$(($RANDOM % 4))
            rand3=$((2*(($RANDOM % 2)+1)))
            n="g${rand1}$rand2"
            if [[ ${!n} =~ ^O+$ ]];then
                #echo Before=$n=${!n}
                eval ${n}=$rand3
                #echo After=$n=$rand3
                loop=0
            fi
        done
    fi
done
