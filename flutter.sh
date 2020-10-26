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

service(){
  
   cd services
   CClass services "$1" service "$serviceEX"
}

model(){

   cd models
   CClass models "$1" model "$modelsEX"
}


CClass(){
    DIR=$1
    arg1=$2
    TYPE=$3
    TMPL=$4
    tn="$(tr '[:lower:]' '[:upper:]' <<< ${TYPE:0:1})${TYPE:1}"
    echo -e 
    if [ "${arg1:$((${#arg1}-1)):${#arg1}}" == '/' ] || [ "${arg1:0:1}" == '/' ]; then
        echo "Format dir/file"
        return
    fi
    FILENAME=$(pwd)/"${arg1}"."${TYPE}".dart
    if [ -f  ${FILENAME} ]; then
        echo -e "File sudah ada"
        return
    fi
    TEMPLATE=""
    l=1
    hC="../"
    IFS='/' read -ra ADDR <<< "$arg1"
    if [ ${#ADDR[@]} == 1 ]; then
        sn="$(tr '[:lower:]' '[:upper:]' <<< ${arg1:0:1})${arg1:1}"
        TEMPLATE+="part of '${hC}app.dart';\n"
        TEMPLATE+=$(echo "$TMPL" | sed -e "s+Example+${sn}${tn}+g")
        echo -e "$TEMPLATE" >> ${FILENAME}
        appRegister  "${DIR}/${arg1}"."${TYPE}".dart
    else
        for i in "${ADDR[@]}"
        do
            if [  ${#ADDR[@]} == $l ]; then
                sn="$(tr '[:lower:]' '[:upper:]' <<< ${i:0:1})${i:1}"
                TEMPLATE+="part of '${hC}app.dart';\n"
                TEMPLATE+=$(echo "$TMPL" | sed -e "s+Example+${sn}${tn}+g")
                echo -e "$TEMPLATE" >> $(pwd)/"${i}"."${TYPE}".dart
                appRegister  "${DIR}/${arg1}"."${TYPE}".dart
                return

            fi
            mkdir $(pwd)/$i
            cd $(pwd)/$i
            hC+="$hC"
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



EXE=$0
DIR=$(dirname "${EXE}")
cd $DIR
cd lib
case "$1" in
    services)
        service $2
        ;;
    models)
        model $2
        ;;
    *)
        showHelp
esac

exit 0

