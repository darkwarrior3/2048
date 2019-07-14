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
inp="2048"
for z in {0..1}; do
    rand1=$(($RANDOM % 4))
    rand2=$(($RANDOM % 4))
    rand3=$((2*(($RANDOM % 2)+1)))
    n="g${rand1}$rand2"
    eval ${n}=$rand3
done
while true;do
    #clear
    figlet -t -c -f pagga $inp
    inp=2048
    for x in {0..3}; do
        v1='g0'$x
        v2='g1'$x
        v3='g2'$x
        v4='g3'$x
        n1=${!v1}
        n2=${!v2}
        n3=${!v3}
        n4=${!v4}
        n1=${#n1}
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
        figlet -t -f future ${var}
    done
    until [[ $inp =~ [WwAaSsDd] ]];do
        read -n1 inp
    done
    case $inp in
        [Ww])
            stat=0
            bias='^\g0.?$'
            direction='+y'
            ;;
        [Ss])
            stat=1
            bias='^\g3.?$'
            direction='-y'
            ;;
        [dD])
            stat=1
            bias='^\g.?3$'
            direction='+x'
            ;;
        [Aa])
            stat=0
            bias='^\g.?0$'
            direction='-x'
            ;;
        *)
            ;;
    esac
    oper1=0
    oper2=0
    case $direction in
        -y)
            let oper1+=1
            ;;
        +y)
            let oper1-=1
            ;;
        -x)
            let oper2-=1
            ;;
        +x)
            let oper2+=1
            ;;
    esac
    echo ""
    for c in {0..2}; do
        if [ $stat -eq 1 ]; then
            for i in {0..3};do
                for n in {0..3};do
                    var='g'${i}${n}
                    var2='g'$((${i}+$oper1))$((${n}+$oper2))
                    var3=${!var}
                    var4=${!var2}
                    if ! [[ $var =~ $bias ]]; then
                        if [[ ${!var} =~ [O]+ ]] && [[ ${!var2} =~ [O]+ ]]; then
                            [ 1 -eq 1 ]
                        elif [[ ${!var} =~ [^O]+ ]] && [[ ${!var2} =~ [O]+ ]]; then
                            eval $var2=${!var}
                            eval $var=O
                        elif [ ${var3//O/} -eq ${var4//O/} ]; then
                            eval $var=O
                            eval let $var2*=2
                        fi

                    fi
                done
            done
        else
            for i in {3..0};do
                for n in {3..0};do
                    var='g'${i}${n}
                    var2='g'$((${i}+$oper1))$((${n}+$oper2))
                    var3=${!var}
                    var4=${!var2}
                    if ! [[ $var =~ $bias ]]; then
                        if [[ ${!var} == O ]] && [[ ${!var2} == O ]]; then
                            [ 1 -eq 1 ]
                        elif [[ ${!var} != O ]] && [[ ${!var2} == O ]]; then
                            eval $var2=${!var}
                            eval $var=O
                        elif [[ ${var3//O/} == ${var4//O/} ]]; then
                            eval $var=O
                            eval let $var2*=2
                        fi

                    fi
                done
            done
        fi
    done
    loop=1
    test=0
    while [ $loop -eq 1 ]; do
        rand1=$(($RANDOM % 4))
        rand2=$(($RANDOM % 4))
        rand3=$((2*(($RANDOM % 2)+1)))
        n="g${rand1}$rand2"
        [[ ${!n} == O ]] && test=1
        if [ $test -eq 1 ]; then
            echo Before=${!n}
            eval ${n}=$rand3
            echo After=$n=$rand3
            loop=0
        fi
    done
done
