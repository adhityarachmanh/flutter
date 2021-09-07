#! /bin/bash
# creator : Adhitya Rachman H
# ver : 1.0

# DEFAULT INFO FROM PC [INFO FILE]
CREATOR=$(whoami)
OS="$OSTYPE"
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
ROUTE="routes.dart"
PROVIDER="providers.dart"

#template
template="tmp"
creatorEX="creator"
modelsEX="model"
serviceEX="service"
screenEX="screen"
widgetEX="widget"
providerEX="provider"
componentEX="component"





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
    if [ -d $PROJECTDIR/$template ] && [ -f $PROJECTDIR/$template/$1 ]; then
        RESPONSE=$(cat $PROJECTDIR/$template/$1)
        local RESPONSE="$RESPONSE"
    fi

}


GComponent(){
    InitLib
    CCreate "$1" component  $componentEX
}

GService(){
    InitLib
    CCreate "services/$1" service  $serviceEX
}

GModel(){
    InitLib
    CCreate "models/$1" model $modelsEX
}
GScreen(){
    InitLib
    CCreate "screens/$1" screen $screenEX
}

GProvider(){
    InitLib
    CCreate "providers/$1" provider $providerEX
}

GWidget(){
    InitLib
    CCreate "widgets/$1" widget $widgetEX
}


CCreate(){
    if [ "$1" == "" ]; then
        echo -e "$MSGERROR\bError create $2 file."
        echo -e "$CGREEN\bFormat:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]."
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
        echo -e "$MSGERROR\bError create $2 file."
        echo -e "$MSGERROR\bInvalid format '/' at first or last path."
        echo -e "$MSGINFO\bFormat:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{infinity}/[FILENAME]"
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
            MARKCONTEXT="MODULE_NAME,CREATOR,DATE,OS"
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
            AppRegister  "${CONTEXT}"."${TYPE}".dart "${CLASSNAME}" "${TYPE}"
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
    cd $PROJECTDIR
    cd lib
}
AppRegister(){
    InitLib
    LT=$(grep  "$3" $(pwd)/$MODULE | tail -1)
    sed -i -e "s+$LT+$LT\npart '$1';+g"  $(pwd)/$MODULE
    # echo -e "\npart '$1';" >> $(pwd)/$MODULE
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
        model     (m)   create model file                                    
        screen    (s)   create screen register navigation                    
        provider  (p)   create provider                                      
        widget    (w)   create widget file
        Component (c)   create Component file
        Service   (svc) create Service file                                   

    
    Example:
        generate  model     models/auth             | g m services/auth
        generate  screen    screens/auth/login      | g s screens/auth/login
        generate  provider  providers/auth          | g p providers/auth
        generate  widget    screens/auth/login      | g w widgets/button
        generate  component components/user/search  | g c components/user/search
        generate  service   services/auth           | g svc services/auth
    """)
    echo -e "$TEMPLATE"
}



ShowHelp(){
    # TEMPLATE=$(echo -e """
    # Available Commands:
    #     generate (g)  Generates files based on a schematic.
    #     package  (p)  Info package or change package.
    #     appname  (an) Info application name or change application name.
    # """)
    TEMPLATE=$(echo -e """
    Available Commands:
        package  (p)  Info package or change package.
        appname  (an) Info application name or change application name.
    """)
    echo -e "$TEMPLATE"
}
ShowVersion(){
    echo -e ""
}

Build(){
    echo -e "build"
}

RegProvider(){
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
        # DIRCONTROLLER=$(pwd)/"$1".controller.dart
        LT=$(grep  "Provider" $(pwd)/$PROVIDER | tail -1)
        TEMPLATE="\tChangeNotifierProvider.value(value: _${SN}Provider()),"
        CHECKCLASS="$(grep -r "${SN}Provider" $(pwd)/$PROVIDER)"
        if [ "$CHECKCLASS" == "" ]; then
            selection=
            until [ "$selection" = "n" ]; do
                echo -e "$CYELLOW\bDo you want to register  $CGREEN\b${SN}Provider$CYELLOW? (y/n)$CRESET"
                old_stty_cfg=$(stty -g)
                stty raw -echo
                selection=$( while ! head -c 1 | grep -i '[yn]' ;do true ;done )
                stty $old_stty_cfg
                case $selection in
                    y ) 
                        # echo -e "$MSGINFO Register provider."
                        ProgressBar 0 "Prepare Process"
                        InitLib
                        ProgressBar 50 "Add Route"
                        sed -i -e "s+$LT+$LT\n$TEMPLATE+g" $(pwd)/$PROVIDER
                        sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$PROVIDER
                        # sleep .5
                        ProgressBar 100 "$MSGSUCCESS Provider $CYELLOW'/${SN}PROVIDER'$CGREEN successfully registered at $PROVIDER.$CRESET"
                        if [ -f $(pwd)/$PROVIDER-e ];then
                            rm $(pwd)/$PROVIDER-e
                        fi
                        exit 0
                    ;;
                    *)
                        echo -e "$MSGWARNING ${SN}Provider is not registered.$CRESET"
                    ;;
                esac
            done
        elif [ "$CHECKCLASS" != "" ]; then
            echo -e "$CGREEN\bProvider $CYELLOW'/${SN}Provider'$CGREEN has been exists at $PROVIDER.$CRESET"
        fi
    fi
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
        # DIRCONTROLLER=$(pwd)/"$1".controller.dart
        LT=$(grep  "Screen" $(pwd)/$ROUTE | tail -1)
        TEMPLATE="\t${SN}Screen.routeName: (context) => ${SN}Screen(),"
        CHECKCLASS="$(grep -r "${SN}Screen" $(pwd)/$ROUTE)"
        if [ "$CHECKCLASS" == "" ]; then
            # selection=
            # until [ "$selection" = "n" ]; do
            #     echo -e "$CYELLOW\bDo you want to register component  $CGREEN\b${SN}Screen$CYELLOW as navigation? (y/n)$CRESET"
            #     old_stty_cfg=$(stty -g)
            #     stty  raw -echo
            #     selection=$( while ! head -c 1 | grep -i '[yn]' ;do true ;done )
            #     stty $old_stty_cfg
            #     case $selection in
            #         y ) 
            #             # echo -e "$MSGINFO Register route."
            #             ProgressBar 0 "Prepare Process"
            #             InitLib
            #             ProgressBar 50 "Add Route"
            #             sed -i -e "s+$LT+$LT\n$TEMPLATE+g" $(pwd)/$ROUTE
            #             sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$ROUTE
            #             # sleep .5
            #             ProgressBar 100 "$MSGSUCCESS Route $CYELLOW'/${SN}Screen'$CGREEN successfully registered at $ROUTE.$CRESET"
            #             if [ -f $(pwd)/$ROUTE-e ];then
            #                 rm $(pwd)/$ROUTE-e
            #             fi
            #             exit 0
            #         ;;
            #         *)
            #             echo -e "$MSGWARNING ${SN}Screen component is not registered as navigation.$CRESET"
            #         ;;
            #     esac
            # done
            ProgressBar 0 "Prepare Process"
            InitLib
            ProgressBar 50 "Add Route"
            sed -i -e "s+$LT+$LT\n$TEMPLATE+g" $(pwd)/$ROUTE
            sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$ROUTE
            # sleep .5
            ProgressBar 100 "$MSGSUCCESS Route $CYELLOW'/${SN}Screen'$CGREEN successfully registered at $ROUTE.$CRESET"
            if [ -f $(pwd)/$ROUTE-e ];then
                rm $(pwd)/$ROUTE-e
            fi
            exit 0
        elif [ "$CHECKCLASS" != "" ]; then
            echo -e "$CGREEN\bRoute $CYELLOW'/${SN}Screen'$CGREEN has been exists at $ROUTE.$CRESET"
        fi
    fi
}



Generate(){
    case "$1" in
        service|svc)
            GService $2
            ;;
        component|c)
            GComponent $2
            ;;
        model|m)
            GModel $2
            ;;
        provider|p)
            GProvider $2
            RegProvider $2
            ;;
        screen|s)
            GScreen $2
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

PackageHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN \bPackage based on a schematic.$CRESET
    usage: package <schematic> [options]
    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to package.

    Available Schematic:
        info     (i)   info current package name IOS and Android
        change   (c)   change package name IOS and Android                                                          
    
    Example:
        package  info   | p i
        package  change | p c
    """)
    echo -e "$TEMPLATE"
}

PackageAndroidAndIOS(){
    # ANDROID
    PkgPoint="package="
    AndroidManifestFile="$PROJECTDIR/android/app/src/main/AndroidManifest.xml"
    AndroidManifestFileDebug="$PROJECTDIR/android/app/src/debug/AndroidManifest.xml"
    AndroidManifestFileProfile="$PROJECTDIR/android/app/src/profile/AndroidManifest.xml"
    AndroidBuildGradlePkgFile="$PROJECTDIR/android/app/build.gradle"
    AndroidPkg="$(grep -F "${PkgPoint}" $AndroidManifestFile)"
    AndroidPkg=$(echo $AndroidPkg | sed -e "s+>++g")
    IFS='"' read -ra AndroidPkg <<< "$AndroidPkg"
    AndroidPkg=${AndroidPkg[1]}
    # IOS
    PkgPoint="PRODUCT_BUNDLE_IDENTIFIER ="
    IOSPkgFile="$PROJECTDIR/ios/Runner.xcodeproj/project.pbxproj"
    IOSPkg="$(grep -F "${PkgPoint}" $IOSPkgFile)"
    IOSPkg=$(echo $IOSPkg | sed -e "s+;++g")
    IFS=' ' read -ra IOSPkg <<< "$IOSPkg"
    IOSPkg=${IOSPkg[2]}
}

AndroidChangePkgFunction(){
    AndroidPkgText="""
package ${NewPkgName}

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
    """
    OLDPath=$(pwd)
    rm -rf $PROJECTDIR/android/app/src/main/kotlin
    mkdir $PROJECTDIR/android/app/src/main/kotlin
    cd $PROJECTDIR/android/app/src/main/kotlin
    IFS='.' read -ra CTX <<< "$NewPkgName"
    for i in "${CTX[@]}"
    do
        mkdir $(pwd)/$i
        cd $(pwd)/$i
    done
    echo -e "$AndroidPkgText" >> $(pwd)/MainActivity.kt
    cd $OLDPath
    AndroidPkgText=$(cat $AndroidManifestFile)
    AndroidPkgText=$(echo "$AndroidPkgText" | sed -e "s+$AndroidPkg+${NewPkgName}+g")
    rm $AndroidManifestFile
    echo -e "$AndroidPkgText" >> $AndroidManifestFile

    AndroidPkgText=$(cat $AndroidManifestFileDebug)
    AndroidPkgText=$(echo "$AndroidPkgText" | sed -e "s+$AndroidPkg+${NewPkgName}+g")
    rm $AndroidManifestFileDebug
    echo -e "$AndroidPkgText" >> $AndroidManifestFileDebug

    AndroidPkgText=$(cat $AndroidManifestFileProfile)
    AndroidPkgText=$(echo "$AndroidPkgText" | sed -e "s+$AndroidPkg+${NewPkgName}+g")
    rm $AndroidManifestFileProfile
    echo -e "$AndroidPkgText" >> $AndroidManifestFileProfile

    AndroidPkgText=$(cat $AndroidBuildGradlePkgFile)
    AndroidPkgText=$(echo "$AndroidPkgText" | sed -e "s+$AndroidPkg+${NewPkgName}+g")
    rm $AndroidBuildGradlePkgFile
    echo -e "$AndroidPkgText" >> $AndroidBuildGradlePkgFile
}

IOSChangePkgFunction(){
    IOSPkgText=$(cat $IOSPkgFile)
    IOSPkgText=$(echo "$IOSPkgText" | sed -e "s+$IOSPkg+$NewPkgName+g")
    rm $IOSPkgFile
    echo -e "$IOSPkgText" >> $IOSPkgFile
}

ChangePackage(){
    PackageAndroidAndIOS
    read -p 'New Package Name: ' NewPkgName
    # selection=
    # until [ "$selection" = "n" ]; do
    #     echo -e "$CYELLOW\bDo you want to change package name to  $CGREEN\b$NewPkgName $CYELLOW? (y/n)$CRESET"
    #     old_stty_cfg=$(stty -g)
    #     stty raw -echo
    #     selection=$( while ! head -c 1 | grep -i '[yn]' ;do true ;done )
    #     stty $old_stty_cfg
    #     case $selection in
    #         y ) 
               
    #         ;;
    #         *)
    #             echo -e "$MSGWARNING Package name has not changed.$CRESET"
    #         ;;
    #     esac
    # done
    IOSChangePkgFunction
    AndroidChangePkgFunction
    flutter clean
    flutter pub get
    echo -e "$MSGWARNING Package name has changed.$CRESET"
    exit 0  
}

PackageInfo(){
    PackageAndroidAndIOS
    echo -e "Android Package Name : $CGREEN$AndroidPkg$CRESET"
    echo -e "IOS Package Name     : $CGREEN$IOSPkg$CRESET"
}

Package(){
    case "$1" in
        change|c)
            ChangePackage $2
            ;;
        info|i)
            PackageInfo
            ;;
        --help|--h|help|h)
            PackageHelp
            ;;
        *)
            echo -e 'For more detailed help run "package --help"'
            ;;
    esac
}

AppNameHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN \bApplication name based on a schematic.$CRESET
    usage: appname <schematic> [options]
    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to package.

    Available Schematic:
        info     (i)   info current application name IOS and Android
        change   (c)   change application name IOS and Android                                                          
    
    Example:
        appname  info   | an i
        appname  change | an c
    """)
    echo -e "$TEMPLATE"
}

AppNameAndroidAndIOS(){
    # ANDROID
    AppNamePoint="android:label="
    AndroidAnFile="$PROJECTDIR/android/app/src/main/AndroidManifest.xml"
    AndroidAn="$(grep -F "${AppNamePoint}" $AndroidAnFile)"
    AndroidAn=$(echo $AndroidAn | sed -e "s+>++g")
    IFS='"' read -ra AndroidAn <<< "$AndroidAn"
    AndroidAn=${AndroidAn[1]}
    # IOS
    AppNamePoint="CFBundleDisplayName"
    IOSAnFile="$PROJECTDIR/ios/Runner/Info.plist"
    IOSAnFindLine="$(grep --line-number "${AppNamePoint}" $IOSAnFile)"
    IFS=':' read -ra IOSAnFindLine <<< "$IOSAnFindLine"
    IOSAnLine=$((${IOSAnFindLine[0]}+1))
    IOSAn=$(awk NR==$IOSAnLine $IOSAnFile)
    IFS='>' read -ra IOSAn <<< "$IOSAn"
    IOSAn=${IOSAn[1]}
    IFS='<' read -ra IOSAn <<< "$IOSAn"
    IOSAn=${IOSAn[0]}
}

AndroidChangeApplicationNameFunction(){
    AndroidAnText=$(cat $AndroidAnFile)
    AndroidAnText=$(echo "\n$AndroidAnText" | sed -e "s+$AndroidAn+${NewAn}+g")
    rm $AndroidAnFile
    echo -e "$AndroidAnText" >> $AndroidAnFile
}

IOSChangeApplicationNameFunction(){
    IOSAnText=$(cat $IOSAnFile)
    IOSAnText=$(echo "\n$IOSAnText" | sed -e "s+$IOSAn+${NewAn}+g")
    rm $IOSAnFile
    echo -e "$IOSAnText" >> $IOSAnFile
}

ChangeAppName(){
    AppNameAndroidAndIOS
    read -p 'New Application Name: ' NewAn
    IOSChangeApplicationNameFunction
    AndroidChangeApplicationNameFunction
    flutter clean
    flutter pub get
    echo -e "$MSGWARNING Application name has changed.$CRESET"
    exit 0  
    # selection=
    # until [ "$selection" = "n" ]; do
    #     echo -e "$CYELLOW\bDo you want to change application name to  $CGREEN\b$NewAn $CYELLOW? (y/n)$CRESET"
    #     old_stty_cfg=$(stty -g)
    #     stty raw -echo 
    #     selection=$( while ! head -c 1 | grep -i '[yn]' ;do true ;done )
    #     stty $old_stty_cfg
    #     case $selection in
    #         y ) 
    #             IOSChangeApplicationNameFunction
    #             AndroidChangeApplicationNameFunction
    #             flutter clean
    #             flutter pub get
    #             echo -e "$MSGWARNING Application name has changed.$CRESET"
    #             exit 0  
    #         ;;
    #         *)
    #             echo -e "$MSGWARNING Application name has not changed.$CRESET"
    #         ;;
    #     esac
    # done
}

AppNameInfo(){
    AppNameAndroidAndIOS
    echo -e "Android Application Name : $CGREEN$AndroidAn$CRESET"
    echo -e "IOS Application Name     : $CGREEN$IOSAn$CRESET"
}

AppName(){
    case "$1" in
        change|c)
            ChangeAppName
            ;;
        info|i)
            AppNameInfo
            ;;
        --help|--h|help|h)
            AppNameHelp
            ;;
        *)
            echo -e 'For more detailed help run "appname --help"'
            ;;
    esac
}

Main(){
    case "$1" in
        # generate|g)
        #     Generate $2 $3
        #     ;;
        appname|an)
            AppName $2
            ;;
        package|p)
            Package $2
            ;;
        build|b)
            Build $2
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
}
if [ -f .flutter-project ] && [ -s  .flutter-project ];then
    PROJECTDIR=$(cat .flutter-project)
    Main $1 $2 $3
else
    echo -e "$MSGERROR\bNo project targets$CRESET"
    if [ -f .flutter-project ];then
        rm .flutter-project
    fi
    read -p "Enter Project Path:" -r FPATH
    FPATH=$(printf "%s\n" "$FPATH")
    if [ -d "$FPATH" ];then
        echo "$FPATH" >> .flutter-project
        sed -i -e '/^[[:space:]]*$/d'  .flutter-project
        echo -e "$MSGSUCCESS Successfully set project targets$CRESET"
        Main $1 $2 $3
    else
        echo -e "$MSGERROR\bInvalid path or path not found error$CRESET"
    fi
fi
exit 0
