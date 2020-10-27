#! /bin/bash
# cre : arh 
# upd : arh 
# ver : 1.0

modelsEX="""
class Example extends Equatable {

    Example();

    factory Example.fromJson(Map<String, dynamic> json) {
        return Example();
    }
    Map<String, dynamic> toJson() {
        return {};
    }

    Example copyWith() => Example();

    @override
    List<Object> get props => [];
}
"""
serviceEX="""
class Example {
    static Future<ResponseAPI> futureExample() async {
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
class Example extends StatelessWidget {
  static final routeName = "/Example";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Example"),
        ),
      ),
    );
  }
}
'''

controllerEX="""
class Example with ChangeNotifier {
  
}
"""

cDir(){
    if [ ! -d $(pwd)/$1 ]; then
        mkdir $1
    fi
}
gService(){
    cDir services
    cd services
    CCreate services "$1" service "$serviceEX"
}

gModel(){
    cDir models
    cd models
    CCreate models "$1" model "$modelsEX"
}
gScreen(){
    cDir app
    cd app
    CCreate app "$1" screen "$screenEX"
}

gController(){
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
    FILENAME=$(pwd)/"${arg1}"."${TYPE}".dart
    TEMPLATE=""
    l=1
    cdB="../"
    IFS='/' read -ra ADDR <<< "$arg1"
    
    if [ "${arg1:$((${#arg1}-1)):${#arg1}}" == '/' ] || [ "${arg1:0:1}" == '/' ]; then
        echo "Format dir/file"
        return
    elif [ -f  ${FILENAME} ]; then
        echo -e "File  sudah ada"
        return
    fi
    if [ ${#ADDR[@]} == 1 ]; then
        sn="$(tr '[:lower:]' '[:upper:]' <<< ${arg1:0:1})${arg1:1}"
        TEMPLATE+="part of '${cdB}app.dart';\n"
        TEMPLATE+=$(echo "$TMPL" | sed -e "s+Example+${sn}${tn}+g")
        checkClass="$(grep -r ${sn}${tn} $DIR)"
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
                TEMPLATE+=$(echo "$TMPL" | sed -e "s+Example+${sn}${tn}+g")
                checkClass="$(grep -r ${sn}${tn} $DIR)"
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
   sed -i -e '/^[[:space:]]*$/d'  $(pwd)/app.dart
   echo -e "\npart '$1';" >> $(pwd)/app.dart
   rm app.dart-e
}

showHelp(){
    echo "help"
}



initLib
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
        ;;
    *)
        showHelp
esac
exit 0

