#! /bin/bash
# creator : Adhitya Rachman H
# ver : 1.0

# DEFAULT INFO FROM PC [INFO FILE]
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

PROGRESSBAR=true
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
    EXE=$0
    DIR=$(dirname "${EXE}")
    if [ -d $DIR/$template ] && [ -f $DIR/$template/$1 ]; then
        RESPONSE=$(cat $DIR/$template/$1)
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
            SN="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
            CHECKCLASS="$(grep -r "class ${SN}${TN}" $DIR)"
            IFS=':' read -ra CLS <<< "$CHECKCLASS"
            CLS=$(echo ${CLS[0]} | sed -e "s+${DIR}++g" )
            if [ "$CHECKCLASS" != "" ]; then
                echo -e "$MSGERROR Duplicate class name $CGREEN${SN}${TN} at $CYELLOW$CLS."
                return
            fi
            MODULE_NAME="${i} ${TYPE}"
            MODULE_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${MODULE_NAME})"
            GTemplate $creatorEX "CREATOR" "${SN}${TN}"
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
            CONTEXT="$(tr '[:upper:]' '[:lower:]' <<< ${CONTEXT})"
            ProgressBar 50 "Register Template"
            AppRegister  "${CONTEXT}"."${TYPE}".dart "${SN}${TN}"
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

PackageHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN \bPackage name application.$CRESET
    usage: package <schematic> [options]
    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to package.

    Available Schematic:
        change (c)   change package name
        info   (i)   info current package name                         
    
    Example:
        package  change com.arh.adhitya | p c com.arh.adhitya
        package  info                   | p i 
    """)
    echo -e "$TEMPLATE"
}

AppLabelHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN \bApplication label.$CRESET
    usage: label <schematic> [options]
    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to application label.

    Available Schematic:
        change (c)   change label application
        info   (i)   info current label application                        
    
    Example:
        label  change "Application Label" | l c "Application Label"
        label  info                       | l i 
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


PkgChange(){
    if [ "$1" == "" ];then
        echo -e "$MSGERROR Invalid format."
        echo -e "$MSGINFO Example:$CYELLOW com.arh.adhitya$CRESET"
        return
    fi
    EXE=$0
    DIR=$(dirname "${EXE}")
    cd $DIR
    NEWPKG="$1"
    PKG=$(grep -r 'package=' $DIR/android)
    IFS=':' read -ra PKG <<< "$PKG"
    IFS='=' read -ra PKG <<< "${PKG[1]}"
    IFS='"' read -ra PKG <<< "${PKG[1]}"
    ANDROCRNTPKG="${PKG[1]}"
    PKG=$(grep -r 'PRODUCT_BUNDLE_IDENTIFIER =' $DIR/ios)
    IFS='=' read -ra PKG <<< "$PKG"
    IFS='"' read -ra PKG <<< "${PKG[1]}"
    IFS=';' read -ra PKG <<< "${PKG[0]}"
    IOSCRNTPKG="$PKG"
    if [ "$ANDROCRNTPKG" == "$NEWPKG" ] && [ "$IOSCRNTPKG" == "$NEWPKG" ];then
        echo -e "$MSGERROR Current package name $CYELLOW$IOSCRNTPKG$CGREEN same with new package name $CYELLOW$NEWPKG"
        return
    fi
    CRNTPKG="$PKG"
    echo -e "$MSGINFO Change package name."
    ProgressBar 0 "Prepare Process"
    FLIST=($(grep -HRl $CRNTPKG $DIR/android && grep -HRl $CRNTPKG $DIR/ios))
    ProgressBar 0 "${#FLIST[@]} File Found"
    # sleep 1
    CFC=1
    for j in "${FLIST[@]}"
    do
        PRGS=$((10*$CFC))
        if (( $PRGS > 100 ));then
            PRGS=$((100))
        else
            PRGS=$((20+$PRGS))
            ProgressBar $PRGS "Change file [$CFC/${#FLIST[@]}]"
        fi
        sed -i -e "s|$CRNTPKG|$NEWPKG|g" "$j"
        if [ -f $j-e ];then
            rm $j-e
        fi
        CFC=$(($CFC+1))
        # sleep .5
    done
    SPLOLD="$CRNTPKG"
    SPLNEW="$NEWPKG"
    IFS='.' read -ra SPLOLD <<< "$SPLOLD"
    IFS='.' read -ra SPLNEW <<< "$SPLNEW"
    mv $DIR/android/app/src/main/kotlin/${SPLOLD[0]} $DIR/android/app/src/main/kotlin/${SPLNEW[0]}
    mv $DIR/android/app/src/main/kotlin/${SPLNEW[0]}/${SPLOLD[1]} $DIR/android/app/src/main/kotlin/${SPLNEW[0]}/${SPLNEW[1]}
    mv $DIR/android/app/src/main/kotlin/${SPLNEW[0]}/${SPLNEW[1]}/${SPLOLD[2]} $DIR/android/app/src/main/kotlin/${SPLNEW[0]}/${SPLNEW[1]}/${SPLNEW[2]}
    ProgressBar 100 "$MSGSUCCESS Change package name $CYELLOW$CRNTPKG$CGREEN to $CYELLOW$NEWPKG$CRESET"
    flutter clean
 
}
PkgInfo(){
    EXE=$0
    DIR=$(dirname "${EXE}")
    cd $DIR
    PKG=$(grep -r 'package=' $DIR/android)
    IFS=':' read -ra PKG <<< "$PKG"
    IFS='=' read -ra PKG <<< "${PKG[1]}"
    IFS='"' read -ra PKG <<< "${PKG[1]}"
    echo -e "$MSGINFO Android package name $CYELLOW${PKG[1]}"
    PKG=$(grep -r 'PRODUCT_BUNDLE_IDENTIFIER =' $DIR/ios)
    IFS='=' read -ra PKG <<< "$PKG"
    IFS='"' read -ra PKG <<< "${PKG[1]}"
    IFS=';' read -ra PKG <<< "${PKG[0]}"
    echo -e "$MSGINFO IOS package name $CYELLOW${PKG[0]}"
}

AppLabelInfo(){
    echo -e "info  app label"
    EXE=$0
    DIR=$(dirname "${EXE}")
    cd $DIR
    PKG=$(grep -r 'android:label' $DIR/android)
    IFS='=' read -ra PKG <<< "${PKG}"
    IFS='"' read -ra PKG <<< "${PKG[1]}"
    echo -e "$MSGINFO Android label $CYELLOW${PKG[1]}"
    PKG=$(grep -r ${PKG[1]} $DIR/ios)
    IFS=':' read -ra PKG <<< "$PKG"
    IFS='>' read -ra PKG <<< "${PKG[1]}"
    IFS='<' read -ra PKG <<< "${PKG[1]}"
    echo -e "$MSGINFO IOS label $CYELLOW${PKG[0]}"

}

AppLabelChange(){
    echo -e "change  app label"
}

Package(){
    case "$1" in
        change|c)
            PkgChange $2
            ;;
        info|i)
            PkgInfo
            ;;
        --help|--h|help|h)
            PackageHelp
            ;;
        *)
            echo -e 'For more detailed help run "package --help"'
            ;;
    esac
}

AppLabel(){
    case "$1" in
        change|c)
            AppLabelChange $2
            ;;
        info|i)
            AppLabelInfo
            ;;
        --help|--h|help|h)
            AppLabelHelp
            ;;
        *)
            echo -e 'For more detailed help run "package --help"'
            ;;
    esac
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
    package|p)
        Package $2 $3
        ;;
    label|l)
        AppLabel $2 $3
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
