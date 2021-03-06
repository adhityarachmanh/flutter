#! /bin/bash
# creator : Adhitya Rachman H
# ver : 1.0

# DEFAULT INFO FROM PC [INFO FILE]

SVCNAME="flutter-tools"
ROOTDIR=

CREATOR=$(whoami)
PRODUCT="ARH"
OS="$OSTYPE"
VERSION="v1.0"
DATE=$(date)


CBLUE="\x1b[34;1m"
CRED="\x1b[31;1m"
CGREEN="\x1b[32;1m"
CYELLOW="\x1b[33;1m"
CRESET="\x1b[39;49;00m"
TERR="\e[1;40;97m"
THIDE="\e[8m"

PROGRESSBAR=false
MSGINFO="$CBLUE[INFO]$CGREEN   "
MSGSUCCESS="$CGREEN[SUCCESS]$CGREEN"
MSGERROR="$CRED[ERROR]$CGREEN  "
MSGWARNING="$CYELLOW[WARNING]$CGREEN"



MODULE="app.dart"
ROUTE="route.dart"

#template
template="tmp"
creatorEX="creator"
modelsEX="model"
serviceEX="service"
screenEX="screen"
widgetEX="widget"
screenControllerEX="controller"

install() {
  echo "Installing $SVCNAME service"
  local fn="/etc/init.d/$SVCNAME"
  cp $0 $fn
  chown root:root $fn
  chmod 755 $fn
  update-rc.d $SVCNAME defaults
  systemctl daemon-reload
}

uninstall() {
  echo "Uninstalling $SVCNAME service"
  local fn="/etc/init.d/$SVCNAME"
  update-rc.d -f $SVCNAME remove
  rm $fn
}

status(){
  # include declaration
  . /lib/lsb/init-functions
  echo "Querying status of $PIDFILE $DAEMON $SVCNAME..."
  status_of_proc -p $PIDFILE "$DAEMON" "$SVCNAME"
}


ProgressBar(){
    if [ "$PROGRESSBAR" = false ]; then
        return
    fi
    max=100
    bar=""
    bk=""
    sp=""
    for (( k=0; k <= $max; ++k ))
    do
        sp+=" "
    done
    for (( l=0; l <= $1; ++l ))
    do
        bar+="#"
        bk+="\b"
    done  
    
    if [ $1 == 100 ]; then
        # sleep .5
        bar=""
        echo -ne "$CGREEN${bar}${sp}${bk} [$1%] $2\r\033[K$2"
        echo -ne '\n'
    else
        # sleep .1
        echo -ne "$CGREEN${bar}${sp}${bk} [$1%] $2\r"
    fi
}

GTemplate(){
    if [ -d $ROOTDIR/$template ] && [ -f $ROOTDIR/$template/$1 ]; then
        RESPONSE=$(cat $ROOTDIR/$template/$1)
        local RESPONSE="$RESPONSE"
    fi

}


GService(){
    InitLib
    CCreate "$1" service  $serviceEX
}

GModel(){
    InitLib
    CCreate "$1" model $modelsEX
}
GScreen(){
    InitLib
    CCreate "$1" screen $screenEX
}

GSController(){
    InitLib
    CCreate "$1" controller $screenControllerEX
}

GWidget(){
    InitLib
    CCreate "$1" widget $widgetEX
}


CCreate(){
    if [ "$1" == "" ]; then
        echo -e "$MSGERROR Error create $2 file \n$CGREEN\bFormat:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]."
        return
    fi
    CONTEXT=$1
    TYPE=$2
    TMPLTURL=$3
    DIR=$(pwd)
    TN="$(tr '[:lower:]' '[:upper:]' <<< ${TYPE:0:1})${TYPE:1}"
    TMPLOUT=""
    IDX=1
    CDB=""
    IFS='/' read -ra CTX <<< "$CONTEXT"
    if [ "${CONTEXT:$((${#CONTEXT}-1)):${#CONTEXT}}" == "/" ] || [ "${CONTEXT:0:1}" == "/" ]; then
        echo -e "$MSGERROR Error create $2 file. \n$MSGERROR Invalid format '/' at first or last path. \n$MSGINFO  Format:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]"
        return
    elif [ -f $(pwd)/"$CONTEXT"."$TYPE".dart ]; then
        echo -e "$MSGERROR "$CONTEXT"."$TYPE".dart file already exists."
        return
    fi
    for i in "${CTX[@]}"
    do
        if [  ${#CTX[@]} == $IDX ]; then
            # SN="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
            SN=""
            IFS='.' read -ra SNS <<< "${i}"
            for j in "${SNS[@]}"
            do
                SN+="$(tr '[:lower:]' '[:upper:]' <<< ${j:0:1})${j:1}"
            done
            CLASSNAME="${SN}${TN}"
            CHECKCLASS="$(grep -r "class ${CLASSNAME}" $DIR)"
            IFS=':' read -ra CLS <<< "$CHECKCLASS"
            CLS=$(echo ${CLS[0]} | sed -e "s+${DIR}++g" )
            if [ "$CHECKCLASS" != "" ]; then
                echo -e "$MSGERROR Duplicate class name $CGREEN${CLASSNAME} at $CYELLOW$CLS."
                return
            fi
            MODULE_NAME=$(echo ${i//'.'/' '})
            MODULE_NAME="${MODULE_NAME} ${TYPE}"
            MODULE_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${MODULE_NAME})"
            GTemplate $creatorEX "CREATOR" "${CLASSNAME}"
            TMPLOUT+="$RESPONSE"
            MARKCONTEXT="MODULE_NAME,CREATOR,DATE,PRODUCT,VERSION,OS"
            IFS=',' read -ra MARKCTX <<< "$MARKCONTEXT"
            for j in "${MARKCTX[@]}"
            do
                TMPLOUT=$(echo "$TMPLOUT" | sed -e "s+_${j}_+${!j}+g")
            done
            GTemplate $TMPLTURL $TYPE
            # echo -e "$MSGINFO Create $CYELLOW${SN}${TN}$CGREEN template."
            ProgressBar 0 "Prepare Process"
            ProgressBar 10 "Replace Template"
            CDB="$(tr '[:upper:]' '[:lower:]' <<< ${CDB})"
            TMPLOUT+="\n\npart of '${CDB}${MODULE}';\n"
            TMPLOUT+=$(echo "\n$RESPONSE" | sed -e "s+Example+${SN}+g")
            ProgressBar 20 "Write Template"
            i="$(tr '[:upper:]' '[:lower:]' <<< ${i})"
            echo -e "$TMPLOUT" >> $(pwd)/"${i}"."${TYPE}".dart
            chmod 777 $(pwd)/"${i}"."${TYPE}".dart
            CONTEXT="$(tr '[:upper:]' '[:lower:]' <<< ${CONTEXT})"
            ProgressBar 50 "Register Template"
            AppRegister  "${CONTEXT}"."${TYPE}".dart "${CLASSNAME}"
        else
            if [ ! -d $(pwd)/$i ]; then
                mkdir $(pwd)/$i
                chmod 777 $(pwd)/$i
            fi
            cd $(pwd)/$i
            CDB+="../"
            IDX=$(($IDX + 1))
        fi
      
    done
  
}

InitLib(){
    # EXE=$0
    # DIR=$(dirname "${EXE}")
    cd $ROOTDIR
    cd lib
}
AppRegister(){
    InitLib
    echo -e "\npart '$1';" >> $(pwd)/$MODULE
    sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$MODULE
    ProgressBar 100 "$MSGSUCCESS Create $CYELLOW${SN}${TN}$CGREEN template."
    echo -e "$MSGSUCCESS Template $CYELLOW$2$CGREEN successfully registered at $MODULE"
    if [ -f $(pwd)/app.dart-e ];then
        rm $(pwd)/app.dart-e
fi
}

GenerateHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN \bGenerates files based on a schematic.$CRESET
    usage: generate <schematic> [options]
    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to generate.

    Available Schematic:
        service   (s)   create service file                                  $CYELLOW\bsuggested in directory services$CRESET
        model     (m)   create model file                                    $CYELLOW\bsuggested in directory models$CRESET
        component (c)   create screen,controller file + register navigation  $CYELLOW\bsuggested in directory screens$CRESET
        widget    (w)   create widget file                                   $CYELLOW\bsuggested in directory widgets$CRESET
    
    Example:
        generate  service   services/auth      | g s services/auth
        generate  model     models/auth        | g m services/auth
        generate  component screens/auth/login | g c screens/auth/login
        generate  widget    screens/auth/login | g w widgets/button
    """)
    echo -e "$TEMPLATE"
}


ShowHelp(){
    echo -e """
    Available Commands:
        generate (g) Generates files based on a schematic.
        package  (p) Info package and change package.
        label    (l) Application Label and  application label.
    """
}
ShowVersion(){
    echo -e ""
}
RegRoute(){
    InitLib
    CONTEXT=$1
    if [ "$CONTEXT" != "" ];then
        IFS='/' read -ra CTX <<< "$CONTEXT"
        if [ ${#CTX[@]} == 1 ];then
            CTX="${CTX[0]}"
        else 
            CTX="${CTX[${#CTX[@]}-1]}"
        fi
        SN="$(tr '[:lower:]' '[:upper:]' <<< ${CTX:0:1})${CTX:1}"
        DIRSCREEN=$(pwd)/"$1".screen.dart
        DIRCONTROLLER=$(pwd)/"$1".controller.dart
        TEMPLATE="\t${SN}Screen.routeName: (ctx) => ChangeNotifierProvider.value(value: ${SN}Controller(), child: ${SN}Screen()),\n};"
        CHECKCLASS="$(grep -r "${SN}Screen" $(pwd)/$ROUTE)"
        if [ -f  $DIRSCREEN ] && [ -f  $DIRCONTROLLER ] && [ "$CHECKCLASS" == "" ]; then
            selection=
            until [ "$selection" = "n" ]; do
                echo -e "$CYELLOW\bDo you want to register component  $CGREEN\b${SN}Screen$CYELLOW as navigation? (y/n)$CRESET"
                old_stty_cfg=$(stty -g)
                stty raw -echo
                selection=$( while ! head -c 1 | grep -i '[yn]' ;do true ;done )
                stty $old_stty_cfg
                case $selection in
                    y ) 
                        # echo -e "$MSGINFO Register route."
                        ProgressBar 0 "Prepare Process"
                        InitLib
                        ProgressBar 50 "Add Route"
                        sed -i -e "s+};++g" $(pwd)/$ROUTE
                        echo -e "$TEMPLATE" >> $(pwd)/$ROUTE
                        sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$ROUTE
                        # sleep .5
                        ProgressBar 100 "$MSGSUCCESS Route $CYELLOW'/${SN}Screen'$CGREEN successfully registered at $ROUTE.$CRESET"
                        if [ -f $(pwd)/route.dart-e ];then
                            rm $(pwd)/route.dart-e
                        fi
                        exit 0
                    ;;
                    *)
                        echo -e "$MSGWARNING ${SN}Screen component is not registered as navigation.$CRESET"
                    ;;
                esac
            done
        elif [ -f  $DIRSCREEN ] && [ -f  $DIRCONTROLLER ] && [ "$CHECKCLASS" != "" ]; then
            echo -e "$CGREEN\bRoute $CYELLOW'/${SN}Screen'$CGREEN has been exists at $ROUTE.$CRESET"
        fi
    fi
}



Generate(){
    case "$1" in
        service|s)
            GService $2
            ;;
        model|m)
            GModel $2
            ;;
        component|c)
            GScreen $2
            GSController $2
            RegRoute $2
            ;;
        widget|w)
            GWidget $2
            ;;
        --help|--h|help|h)
            GenerateHelp
            ;;
        *)
            echo -e 'For more detailed help run "generate --help"'
            ;;
    esac
}

case "$1" in
    install|i)
        install
        ;;
    uninstall|u)
        uninstall
        ;;
    status|s)
        status
        ;;
    generate|g)
        Generate $2 $3
        ;;
    test|t)
        DIR=$(dirname "${0}")
        FILENAME=$(basename "${0}")
        TEMPLATEOUT=$(cat $0)
        TEMPLATEOUT=$(echo "$TEMPLATEOUT" | sed -e "s+__ROOTDIR__+${DIR}+g")
        echo -e "$TEMPLATEOUT" >> $DIR/$FILENAME
        # echo -e "$FILENAME"
        ;;
    # package|p)
    #     Package $2 $3
    #     ;;
    # label|l)
    #     AppLabel $2 $3
    #     ;;
    --help|--h|help|h)
        ShowHelp
        ;;
    --version|--v|version|v)
        ShowVersion
        ;;
    *)
        echo -e 'For more detailed help run "--help"'
        ;;
esac
exit 0
#! /bin/bash
# creator : Adhitya Rachman H
# ver : 1.0

# DEFAULT INFO FROM PC [INFO FILE]

SVCNAME="flutter-tools"
ROOTDIR="/home/arh/projects/flutter/flutter"

CREATOR=$(whoami)
PRODUCT="ARH"
OS="$OSTYPE"
VERSION="v1.0"
DATE=$(date)


CBLUE="[34;1m"
CRED="[31;1m"
CGREEN="[32;1m"
CYELLOW="[33;1m"
CRESET="[39;49;00m"
TERR="[1;40;97m"
THIDE="[8m"

PROGRESSBAR=false
MSGINFO="$CBLUE[INFO]$CGREEN   "
MSGSUCCESS="$CGREEN[SUCCESS]$CGREEN"
MSGERROR="$CRED[ERROR]$CGREEN  "
MSGWARNING="$CYELLOW[WARNING]$CGREEN"



MODULE="app.dart"
ROUTE="route.dart"

#template
template="tmp"
creatorEX="creator"
modelsEX="model"
serviceEX="service"
screenEX="screen"
widgetEX="widget"
screenControllerEX="controller"

install() {
  echo "Installing $SVCNAME service"
  local fn="/etc/init.d/$SVCNAME"
  cp $0 $fn
  chown root:root $fn
  chmod 755 $fn
  update-rc.d $SVCNAME defaults
  systemctl daemon-reload
}

uninstall() {
  echo "Uninstalling $SVCNAME service"
  local fn="/etc/init.d/$SVCNAME"
  update-rc.d -f $SVCNAME remove
  rm $fn
}

status(){
  # include declaration
  . /lib/lsb/init-functions
  echo "Querying status of $PIDFILE $DAEMON $SVCNAME..."
  status_of_proc -p $PIDFILE "$DAEMON" "$SVCNAME"
}


ProgressBar(){
    if [ "$PROGRESSBAR" = false ]; then
        return
    fi
    max=100
    bar=""
    bk=""
    sp=""
    for (( k=0; k <= $max; ++k ))
    do
        sp+=" "
    done
    for (( l=0; l <= $1; ++l ))
    do
        bar+="#"
        bk+=""
    done  
    
    if [ $1 == 100 ]; then
        # sleep .5
        bar=""
        echo -ne "$CGREEN${bar}${sp}${bk} [$1%] $2
[K$2"
        echo -ne '
'
    else
        # sleep .1
        echo -ne "$CGREEN${bar}${sp}${bk} [$1%] $2
"
    fi
}

GTemplate(){
    if [ -d $ROOTDIR/$template ] && [ -f $ROOTDIR/$template/$1 ]; then
        RESPONSE=$(cat $ROOTDIR/$template/$1)
        local RESPONSE="$RESPONSE"
    fi

}


GService(){
    InitLib
    CCreate "$1" service  $serviceEX
}

GModel(){
    InitLib
    CCreate "$1" model $modelsEX
}
GScreen(){
    InitLib
    CCreate "$1" screen $screenEX
}

GSController(){
    InitLib
    CCreate "$1" controller $screenControllerEX
}

GWidget(){
    InitLib
    CCreate "$1" widget $widgetEX
}


CCreate(){
    if [ "$1" == "" ]; then
        echo -e "$MSGERROR Error create $2 file 
$CGREENFormat:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]."
        return
    fi
    CONTEXT=$1
    TYPE=$2
    TMPLTURL=$3
    DIR=$(pwd)
    TN="$(tr '[:lower:]' '[:upper:]' <<< ${TYPE:0:1})${TYPE:1}"
    TMPLOUT=""
    IDX=1
    CDB=""
    IFS='/' read -ra CTX <<< "$CONTEXT"
    if [ "${CONTEXT:$((${#CONTEXT}-1)):${#CONTEXT}}" == "/" ] || [ "${CONTEXT:0:1}" == "/" ]; then
        echo -e "$MSGERROR Error create $2 file. 
$MSGERROR Invalid format '/' at first or last path. 
$MSGINFO  Format:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]"
        return
    elif [ -f $(pwd)/"$CONTEXT"."$TYPE".dart ]; then
        echo -e "$MSGERROR "$CONTEXT"."$TYPE".dart file already exists."
        return
    fi
    for i in "${CTX[@]}"
    do
        if [  ${#CTX[@]} == $IDX ]; then
            # SN="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
            SN=""
            IFS='.' read -ra SNS <<< "${i}"
            for j in "${SNS[@]}"
            do
                SN+="$(tr '[:lower:]' '[:upper:]' <<< ${j:0:1})${j:1}"
            done
            CLASSNAME="${SN}${TN}"
            CHECKCLASS="$(grep -r "class ${CLASSNAME}" $DIR)"
            IFS=':' read -ra CLS <<< "$CHECKCLASS"
            CLS=$(echo ${CLS[0]} | sed -e "s+${DIR}++g" )
            if [ "$CHECKCLASS" != "" ]; then
                echo -e "$MSGERROR Duplicate class name $CGREEN${CLASSNAME} at $CYELLOW$CLS."
                return
            fi
            MODULE_NAME=$(echo ${i//'.'/' '})
            MODULE_NAME="${MODULE_NAME} ${TYPE}"
            MODULE_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${MODULE_NAME})"
            GTemplate $creatorEX "CREATOR" "${CLASSNAME}"
            TMPLOUT+="$RESPONSE"
            MARKCONTEXT="MODULE_NAME,CREATOR,DATE,PRODUCT,VERSION,OS"
            IFS=',' read -ra MARKCTX <<< "$MARKCONTEXT"
            for j in "${MARKCTX[@]}"
            do
                TMPLOUT=$(echo "$TMPLOUT" | sed -e "s+_${j}_+${!j}+g")
            done
            GTemplate $TMPLTURL $TYPE
            # echo -e "$MSGINFO Create $CYELLOW${SN}${TN}$CGREEN template."
            ProgressBar 0 "Prepare Process"
            ProgressBar 10 "Replace Template"
            CDB="$(tr '[:upper:]' '[:lower:]' <<< ${CDB})"
            TMPLOUT+="

part of '${CDB}${MODULE}';
"
            TMPLOUT+=$(echo "
$RESPONSE" | sed -e "s+Example+${SN}+g")
            ProgressBar 20 "Write Template"
            i="$(tr '[:upper:]' '[:lower:]' <<< ${i})"
            echo -e "$TMPLOUT" >> $(pwd)/"${i}"."${TYPE}".dart
            chmod 777 $(pwd)/"${i}"."${TYPE}".dart
            CONTEXT="$(tr '[:upper:]' '[:lower:]' <<< ${CONTEXT})"
            ProgressBar 50 "Register Template"
            AppRegister  "${CONTEXT}"."${TYPE}".dart "${CLASSNAME}"
        else
            if [ ! -d $(pwd)/$i ]; then
                mkdir $(pwd)/$i
                chmod 777 $(pwd)/$i
            fi
            cd $(pwd)/$i
            CDB+="../"
            IDX=$(($IDX + 1))
        fi
      
    done
  
}

InitLib(){
    # EXE=$0
    # DIR=$(dirname "${EXE}")
    cd $ROOTDIR
    cd lib
}
AppRegister(){
    InitLib
    echo -e "
part '$1';" >> $(pwd)/$MODULE
    sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$MODULE
    ProgressBar 100 "$MSGSUCCESS Create $CYELLOW${SN}${TN}$CGREEN template."
    echo -e "$MSGSUCCESS Template $CYELLOW$2$CGREEN successfully registered at $MODULE"
    if [ -f $(pwd)/app.dart-e ];then
        rm $(pwd)/app.dart-e
fi
}

GenerateHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN Generates files based on a schematic.$CRESET
    usage: generate <schematic> [options]
    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to generate.

    Available Schematic:
        service   (s)   create service file                                  $CYELLOWsuggested in directory services$CRESET
        model     (m)   create model file                                    $CYELLOWsuggested in directory models$CRESET
        component (c)   create screen,controller file + register navigation  $CYELLOWsuggested in directory screens$CRESET
        widget    (w)   create widget file                                   $CYELLOWsuggested in directory widgets$CRESET
    
    Example:
        generate  service   services/auth      | g s services/auth
        generate  model     models/auth        | g m services/auth
        generate  component screens/auth/login | g c screens/auth/login
        generate  widget    screens/auth/login | g w widgets/button
    """)
    echo -e "$TEMPLATE"
}

ShowHelp(){
    echo -e """
    Available Commands:
        generate (g) Generates files based on a schematic.
        package  (p) Info package and change package.
        label    (l) Application Label and  application label.
    """
}
ShowVersion(){
    echo -e ""
}
RegRoute(){
    InitLib
    CONTEXT=$1
    if [ "$CONTEXT" != "" ];then
        IFS='/' read -ra CTX <<< "$CONTEXT"
        if [ ${#CTX[@]} == 1 ];then
            CTX="${CTX[0]}"
        else 
            CTX="${CTX[${#CTX[@]}-1]}"
        fi
        SN="$(tr '[:lower:]' '[:upper:]' <<< ${CTX:0:1})${CTX:1}"
        DIRSCREEN=$(pwd)/"$1".screen.dart
        DIRCONTROLLER=$(pwd)/"$1".controller.dart
        TEMPLATE="	${SN}Screen.routeName: (ctx) => ChangeNotifierProvider.value(value: ${SN}Controller(), child: ${SN}Screen()),
};"
        CHECKCLASS="$(grep -r "${SN}Screen" $(pwd)/$ROUTE)"
        if [ -f  $DIRSCREEN ] && [ -f  $DIRCONTROLLER ] && [ "$CHECKCLASS" == "" ]; then
            selection=
            until [ "$selection" = "n" ]; do
                echo -e "$CYELLOWDo you want to register component  $CGREEN${SN}Screen$CYELLOW as navigation? (y/n)$CRESET"
                old_stty_cfg=$(stty -g)
                stty raw -echo
                selection=$( while ! head -c 1 | grep -i '[yn]' ;do true ;done )
                stty $old_stty_cfg
                case $selection in
                    y ) 
                        # echo -e "$MSGINFO Register route."
                        ProgressBar 0 "Prepare Process"
                        InitLib
                        ProgressBar 50 "Add Route"
                        sed -i -e "s+};++g" $(pwd)/$ROUTE
                        echo -e "$TEMPLATE" >> $(pwd)/$ROUTE
                        sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$ROUTE
                        # sleep .5
                        ProgressBar 100 "$MSGSUCCESS Route $CYELLOW'/${SN}Screen'$CGREEN successfully registered at $ROUTE.$CRESET"
                        if [ -f $(pwd)/route.dart-e ];then
                            rm $(pwd)/route.dart-e
                        fi
                        exit 0
                    ;;
                    *)
                        echo -e "$MSGWARNING ${SN}Screen component is not registered as navigation.$CRESET"
                    ;;
                esac
            done
        elif [ -f  $DIRSCREEN ] && [ -f  $DIRCONTROLLER ] && [ "$CHECKCLASS" != "" ]; then
            echo -e "$CGREENRoute $CYELLOW'/${SN}Screen'$CGREEN has been exists at $ROUTE.$CRESET"
        fi
    fi
}


Generate(){
    case "$1" in
        service|s)
            GService $2
            ;;
        model|m)
            GModel $2
            ;;
        component|c)
            GScreen $2
            GSController $2
            RegRoute $2
            ;;
        widget|w)
            GWidget $2
            ;;
        --help|--h|help|h)
            GenerateHelp
            ;;
        *)
            echo -e 'For more detailed help run "generate --help"'
            ;;
    esac
}

case "$1" in
    install|i)
        install
        ;;
    uninstall|u)
        uninstall
        ;;
    status|s)
        status
        ;;
    generate|g)
        Generate $2 $3
        ;;
    --help|--h|help|h)
        ShowHelp
        ;;
    --version|--v|version|v)
        ShowVersion
        ;;
    *)
        echo -e 'For more detailed help run "--help"'
        ;;
esac
exit 0
