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


modelsEX="""
class ExampleModel extends Equatable {

    ExampleModel();

    factory ExampleModel.fromJson(Map<String, dynamic> json) {
        return ExampleModel();
    }
    Map<String, dynamic> toJson() {
        return {};
    }

    ExampleModel copyWith() => ExampleModel();

    @override
    List<Object> get props => [];
}
"""

serviceEX="""
class ExampleService {
    static Future<ResponseAPI> example() async {
        try {
            // GET : var client = await rest.get('URL',headers:{});
            var client = await rest.put('URL',data:{},headers:{});
            var response = ResponseAPI.fromJson(jsonDecode(client.body));
             if (response.s == 1) {
                return ResponseAPI(s: 1, msg: 'Error');
            }
            return response;
        } catch (e) {
            return ResponseAPI(s: 1, msg: 'Server Error');
        }
    }
}
"""

screenEX='''
class ExampleScreen extends StatelessWidget {
  static final routeName = "/ExampleScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Global controller
    final globalState = Provider.of<IndexController>(context);
    final globalDispatch = Provider.of<IndexController>(context, listen: false);
    // Route
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    // Local controller
    final state = Provider.of<ExampleController>(context);
    final dispatch = Provider.of<ExampleController>(context, listen: false);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Center(
          child: Text("ExampleScreen"),
        ),
      ),
    );
  }
}
'''

controllerEX="""
class ExampleController with ChangeNotifier {

}
"""


GService(){
    InitLib
    CCreate "$1" service "$serviceEX"
}

GModel(){
    InitLib
    CCreate "$1" model "$modelsEX"
}
GScreen(){
    InitLib
    CCreate "$1" screen "$screenEX"
}

GController(){
    InitLib
    CCreate "$1" controller "$controllerEX"
}



CCreate(){
    if [ "$1" == "" ]; then
        echo -e "$CRED\bError create $2 file \n$CGREEN\bExample:$CYELLOW [FILENAME] $CGREEN|$CYELLOW [DIR]{unlimited}/[FILENAME]$CRESET"
        return
    fi
    CONTEXT=$1
    TYPE=$2
    TMPLIN=$3
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
        echo -e "$CRED"$CONTEXT"."$TYPE".dart$CRESET$CYELLOW[FILE EXISTS]$CRESET"
        return
    fi
    for i in "${CTX[@]}"
    do
        if [  ${#CTX[@]} == $IDX ]; then
            SN="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
            TMPLOUT+="part of '${CDB}${MODULE}';\n"
            TMPLOUT+=$(echo "$TMPLIN" | sed -e "s+Example+${SN}+g")
            CHECKCLASS="$(grep -r "class ${SN}${TN}" $DIR)"
            IFS=':' read -ra CLS <<< "$CHECKCLASS"
            CLS=$(echo ${CLS[0]} | sed -e "s+${DIR}++g" )
            if [ "$CHECKCLASS" != "" ]; then
                echo -e "\a$CRED\bDuplicate class name $CGREEN${SN}${TN}$CRESET at $CYELLOW$CLS$CRESET"
                exit 0
            fi
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
    echo -e "$CGREEN $1 registered $CRESET"
}

GenerateHelp(){
    TEMPLATE=$(echo -e """
    $CGREEN \bGenerates files based on a schematic.$CRESET
    usage: generate <schematic> [options]

    arguments:
        $CGREEN"schematic"$CRESET
            The schematic or collection:schematic to generate.

    Available Schematic:
        service (s)
        model (m)
        component (c)
    
    Example:
        generate  service   services/auth  | g s services/auth
        generate  model     models/auth    | g m services/auth
        generate  component app/auth/login | g c app/auth/login
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
        CTX="${CTX[1]}"
    fi
    SN="$(tr '[:lower:]' '[:upper:]' <<< ${CTX:0:1})${CTX:1}"
    DIRSCREEN=$(pwd)/"$1".screen.dart
    DIRCONTROLLER=$(pwd)/"$1".controller.dart
    TEMPLATE="\t${SN}Screen.routeName: (ctx) => ChangeNotifierProvider.value(value: ${SN}Controller(), child: ${SN}Screen()),\n};"
    CHECKCLASS="$(grep -r "${SN}Screen" $(pwd)/$ROUTE)"
    if [ -f  $DIRSCREEN ] && [ -f  $DIRCONTROLLER ] && [ "$CHECKCLASS" == "" ]; then
        InitLib
        sed -i -e "s+};+$TEMPLATE+g" $(pwd)/$ROUTE
        sed -i -e '/^[[:space:]]*$/d'  $(pwd)/$ROUTE
    fi
}

Generate(){
    case "$1" in
        services|s)
            GService $2
            ;;
        models|m)
            GModel $2
            ;;
        component|c)
            GScreen $2
            GController $2
            RegRoute $2
            ;;
        --help|--h|help|h)
            GenerateHelp
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
   
esac
exit 0

