#! /bin/bash
# cre : arh 
# upd : arh 
# ver : 1.0

CBLUE="\x1b[34;1m"
CRED="\x1b[31;1m"
CGREEN="\x1b[32;1m"
CYELLOW="\x1b[33;1m"
CRESET="\x1b[39;49;00m"
TERR="\e[1;40;97m"
THIDE="\e[8m"

MODULE="app.dart"
ROUTE="route.dart"
modelsEX="3mDsDlv"
serviceEX="3mDsiiJ"
screenEX="2HNVjJq"
widgetEX="3e973Sw"
screenControllerEX="2J8Dl4K"

GTemplate(){
    HTTPS=$(echo $LINES | curl "https://bit.ly/$1"| grep -r https )
    IFS='"' read -ra CX <<< "$HTTPS"
    URL="${CX[1]}"
    RESPONSE=$(curl --write-out '%{http_code}' --silent --output /dev/null $URL)
    if [ "$RESPONSE" == "200" ];then
        echo -e "$CGREEN\bRequest Success with status code$CRESET[$RESPONSE]"
        RESPONSE=$(curl $URL )
        local RESPONSE="$RESPONSE"
    else
        echo -e "$CRED\bRequest failed with status code$CRESET[$RESPONSE]"
        exit 0
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
        echo -e "$CRED\bError create $2 file \n$CGREEN\bExample:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]$CRESET"
        return
    fi
    CONTEXT=$1
    TYPE=$2
    TMPLTURL=$3
    DIR=$(pwd)
    TN="$(tr '[:lower:]' '[:upper:]' <<< ${TYPE:0:1})${TYPE:1}"
    FILENAME=$(pwd)/"$CONTEXT"."$TYPE".dart
    TMPLOUT=""
    IDX=1
    CDB=""
    IFS='/' read -ra CTX <<< "$CONTEXT"
    if [ "${CONTEXT:$((${#CONTEXT}-1)):${#CONTEXT}}" == '/' ] || [ "${CONTEXT:0:1}" == '/' ]; then
        echo -e "$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{unlimited}/[FILENAME]$CRESET"
        return
    elif [ -f  ${FILENAME} ]; then
        echo -e "$CRED"$CONTEXT"."$TYPE".dart$CRESET$CYELLOW file already exists$CRESET."
        return
    fi
    for i in "${CTX[@]}"
    do
        if [  ${#CTX[@]} == $IDX ]; then
            SN="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
            CHECKCLASS="$(grep -r "class ${SN}${TN}" $DIR)"
            IFS=':' read -ra CLS <<< "$CHECKCLASS"
            CLS=$(echo ${CLS[0]} | sed -e "s+${DIR}++g" )
            if [ "$CHECKCLASS" != "" ]; then
                echo -e "\a$CRED\bDuplicate class name $CGREEN${SN}${TN}$CRESET at $CYELLOW$CLS$CRESET"
                return
            fi
            GTemplate $TMPLTURL
            TMPLOUT+="part of '${CDB}${MODULE}';\n"
            TMPLOUT+=$(echo "\n$RESPONSE" | sed -e "s+Example+${SN}+g")
            echo -e "$TMPLOUT" >> $(pwd)/"${i}"."${TYPE}".dart
            AppRegister  "${CONTEXT}"."${TYPE}".dart
        else
            if [ ! -d $(pwd)/$i ]; then
                mkdir $(pwd)/$i
            fi
            cd $(pwd)/$i
            CDB+="../"
            IDX=$(($IDX + 1))
        fi
      
    done
  
}

InitLib(){
    EXE=$0
    DIR=$(dirname "${EXE}")
    cd $DIR
    cd lib
}
AppRegister(){
   InitLib
    echo -e "\npart '$1';" >> $(pwd)/$MODULE
    sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$MODULE
    echo -e "$CGREEN$1 successfully registered at $MODULE$CRESET"
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
    """
}
ShowVersion(){
    echo -e ""
}

RegRoute(){
    InitLib
    CONTEXT=$1
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
        InitLib
        sed -i -e "s+};++g" $(pwd)/$ROUTE
        echo -e "$TEMPLATE" >> $(pwd)/$ROUTE
        sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$ROUTE
        echo -e "$CGREEN\bRoute '/${SN}Screen' successfully registered at $ROUTE.$CRESET"
        if [ -f $(pwd)/route.dart-e ];then
            rm $(pwd)/route.dart-e
        fi
    else
        echo -e "$CGREEN\bRoute '/${SN}Screen' has been exists at $ROUTE.$CRESET"
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

