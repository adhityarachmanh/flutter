#! /bin/bash
# cre : arh 
# upd : arh 
# ver : 1.0



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
            // GET : var client = await rest.get('URL',{});
            var client = await rest.put('URL',{},{});
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
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    final state = Provider.of<ExampleController>(context);
    final dispatch = Provider.of<ExampleController>(context, listen: false);
    return Scaffold(
      body: Container(
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

cDir(){
    if [ ! -d $(pwd)/$1 ]; then
        mkdir $1
    fi
}
gService(){
    initLib
    cDir services
    cd services
    CCreate services "$1" service "$serviceEX"
}

gModel(){
    initLib
    cDir models
    cd models
    CCreate models "$1" model "$modelsEX"
}
gScreen(){
    initLib
    cDir app
    cd app
    CCreate app "$1" screen "$screenEX"
}

gController(){
    initLib
    cDir app
    cd app
    CCreate app "$1" controller "$controllerEX"
   
}



CCreate(){
    DNAME=$1
    arg1=$2
    TYPE=$3
    TMPL=$4
    DIR=$(pwd)
    tn="$(tr '[:lower:]' '[:upper:]' <<< ${TYPE:0:1})${TYPE:1}"
    if [ "${arg1:$((${#arg1}-1)):${#arg1}}" == '/' ] || [ "${arg1:0:1}" == '/' ]; then
        echo "Format dir/file"
        return
    fi
    FILENAME=$(pwd)/"$arg1"."$TYPE".dart
    if [ -f  ${FILENAME} ]; then
        echo -e "File  sudah ada"
        return
    fi
    TEMPLATE=""
    l=1
    cdB="../"
    IFS='/' read -ra ADDR <<< "$arg1"
    if [ ${#ADDR[@]} == 1 ]; then
        sn="$(tr '[:lower:]' '[:upper:]' <<< ${arg1:0:1})${arg1:1}"
        TEMPLATE+="part of '${cdB}app.dart';\n"
        TEMPLATE+=$(echo "$TMPL" | sed -e "s+Example+${sn}+g")
        checkClass="$(grep -r "class ${sn}${tn}" $DIR)"
        if [ "$checkClass" != "" ]; then
            echo "Nama class ${sn}${tn} sudah digunakan"
            exit 0
        fi
        echo -e "$TEMPLATE" >> ${FILENAME}
        appRegister  "${DNAME}/${arg1}"."${TYPE}".dart
    else
        for i in "${ADDR[@]}"
        do
            if [  ${#ADDR[@]} == $l ]; then
                sn="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
                TEMPLATE+="part of '${cdB}app.dart';\n"
                TEMPLATE+=$(echo "$TMPL" | sed -e "s+Example+${sn}+g")
                checkClass="$(grep -r "class ${sn}${tn}" $DIR)"
                if [ "$checkClass" != "" ]; then
                    echo "Nama class ${sn}${tn} sudah digunakan"
                    exit 0
                fi
                echo -e "$TEMPLATE" >> $(pwd)/"${i}"."${TYPE}".dart
                appRegister  "${DNAME}/${arg1}"."${TYPE}".dart
                return

            fi
            if [ ! -d $(pwd)/$i ]; then
                mkdir $(pwd)/$i
            fi
            cd $(pwd)/$i
            cdB+=$cdB
            l=$(($l + 1))
        done
        
    fi
}

initLib(){
    EXE=$0
    DIR=$(dirname "${EXE}")
    cd $DIR
    cd lib
}
appRegister(){
   initLib
    echo -e "\npart '$1';" >> $(pwd)/app.dart
    sed -i -e '/^[[:space:]]*$/d'  $(pwd)/app.dart
}

showHelp(){
    echo "help"
}



regRoute(){
    initLib
    arg1="$1"
    
    IFS='/' read -ra ADDR <<< "$arg1"
    if [ ${#ADDR[@]} == 1 ];then
        ADDR="${ADDR[0]}"
    else 
        ADDR="${ADDR[1]}"
    fi
    sn="$(tr '[:lower:]' '[:upper:]' <<< ${ADDR:0:1})${ADDR:1}"
    S=$(pwd)/app/"$1".screen.dart
    C=$(pwd)/app/"$1".controller.dart

    TEMPLATE="\t${sn}Screen.routeName: (ctx) => ChangeNotifierProvider.value(value: ${sn}Controller(), child: ${sn}Screen()),\n};"
    checkClass="$(grep -r "${sn}Screen" $(pwd)/route.dart)"
    if [ -f  $S ] && [ -f  $C ] && [ "$checkClass" == "" ]; then
        initLib
        sed -i -e "s+};+$TEMPLATE+g" $(pwd)/route.dart
        sed -i -e '/^[[:space:]]*$/d'  $(pwd)/route.dart
    fi
}



case "$1" in
    services|s)
        gService $2
        ;;
    models|m)
        gModel $2
        ;;
    component|c)
        gScreen $2
        gController $2
        regRoute $2
        ;;
    *)
        showHelp
esac
exit 0

