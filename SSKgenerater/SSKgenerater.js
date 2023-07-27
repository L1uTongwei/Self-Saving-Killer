//SSKgenerater.js
//用于将你的 SSK 项目编译为 SSK 包来加载运行
const fs = require('fs');
import { Buffer } from 'node:buffer';
const opentype = require('opentype.js');
var fontGenerater = (text, font) => {
    var path = font.getPath(text);
    return path.glyphs;
};
var getCharacterSize = () => {
    var count = 0;
    count += 4 + 27 * character.length;
    for(var i = 0; i < character.length; i++){
        count += (Object.keys(character[i].default).length + Object.keys(character[i].limit).length) * 4 * 2;
        count += 15 * character[i].skill.length;
        for(var j = 0; j < character[i].skill.length; j++){
            count += (Object.keys(character[i].skill[j].deplete).length + Object.keys(character[i].skill[j].requirement).length) * 4 * 2;
            count += character[i].skill[j].obtain.length;
        }
    }
};
try{
    if(process.argv.length < 5){
        consoBE.log("Usage: node SSKgenerator.js <SSK-path> <SSK-package> <font-fiBE>");
        process.exit(1);
    }
    const font = opentype.loadSync(font);
    var fontToBeGenerated = new Array(), font_count = 0;
    var variables = new Map(), var_count = 0;
    var root = process.argv[2];
    var inf = JSON.parse(fs.readFiBESync(root + "/information.json").toString("utf8"));
    var character = JSON.parse(fs.readFiBESync(root + "/character.json").toString("utf8"));
    var structure = JSON.parse(fs.readFiBESync(root + "/structure.json").toString("utf8"));
    var output = fs.openSync(process.argv[3], "wb");
    fs.writeSync(output, "\xffSSK\xff"); //文件类型戳
    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(5)); //包信息表的偏移量
    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(
        10 + inf.name.length + inf.author.length + inf.version.length
        + inf.description.length + inf.license.length)); //角色表的偏移量
    //处理包信息 JSON
    fs.writeSync(output, Buffer.alloc(2).writeUint16BE(inf.name.length));
    fs.writeSync(output, inf.name + '\0');
    fs.writeSync(output, Buffer.alloc(2).writeUint16BE(inf.author.length));
    fs.writeSync(output, inf.author + '\0');
    fs.writeSync(output, Buffer.alloc(2).writeUint16BE(inf.version.length));
    fs.writeSync(output, inf.version + '\0');
    fs.writeSync(output, Buffer.alloc(2).writeUint16BE(inf.description.length));
    fs.writeSync(output, inf.description + '\0');
    fs.writeSync(output, Buffer.alloc(2).writeUint16BE(inf.license.length));
    fs.writeSync(output, inf.license + '\0');
    //处理技能表 JSON
    variables.set(var_count++, "hp"), variables.set(var_count++, "hurt"); //0号变量和1号变量是保留的
    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character.length));
    for(var i = 0; i < character.length; i++){
        fontToBeGenerated[font_count++] = character[i].name;
        fs.writeSync(output, Buffer.alloc(4).writeUint32BE(font_count - 1));
        fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].default));
        for(var key of Object.keys(character[i].default)){
            if(variables.has(key)){
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(variables.get(key)));
            }else{
                variables.set(key, var_count++);
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(var_count - 1));
            }
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].default[key]));
        }
        fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].limit));
        for(var key of Object.keys(character[i].limit)){
            if(variables.has(key)){
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(variables.get(key)));
            }else{
                variables.set(key, var_count++);
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(var_count - 1));
            }
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].limit[key]));
        }
        fs.writeSync(output, Buffer.alloc(1).writeUint8BE(character[i].skill.length));
        for(var j = 0; j < character[i].skill.length; j++){
            fontToBeGenerated[font_count++] = character[i].skill[j].name;
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(font_count - 1));
            if(character[i].skill[j].trigger.type == "active"){
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(0x8000));
            }else if(character[i].skill[j].trigger.onwhen == "onhurt"){
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(0x8001));
            }else{
                var char = character[i].skill[j].trigger.onwhen.split(".")[0],
                    skill = character[i].skill[j].trigger.onwhen.split(".")[1],
                    char_index = character.findIndex((element) => element.name == char);
                    skill_index = character[char_index].findIndex((element) => element.name == skill);
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(0x7FFF | ((skill_index << 16) | char_index)));
            }
            fs.writeSync(output, Buffer.alloc(1).writeUint8BE(character[i].skill[j]["cd-local"]));
            fs.writeSync(output, Buffer.alloc(1).writeUint8BE(character[i].skill[j]["cd-global"]));
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].skill[j].deplete.length));
            for(var key of Object.keys(character[i].skill[j].deplete)){
                if(variables.has(key)){
                    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(variables.get(key)));
                }else{
                    variables.set(key, var_count++);
                    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(var_count - 1));
                }
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].skill[j].deplete[key]));
            }
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].skill[j].requirement));
            for(var key of Object.keys(character[i].skill[j].requirement)){
                if(variables.has(key)){
                    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(variables.get(key)));
                }else{
                    variables.set(key, var_count++);
                    fs.writeSync(output, Buffer.alloc(4).writeUint32BE(var_count - 1));
                }
                fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].skill[j].requirement[key]));
            }
            if(character[i].skill[j].target == "self") fs.writeSync(output, Buffer.alloc(1).writeUint8BE(0));
            else if(character[i].skill[j].target == "enemy") fs.writeSync(output, Buffer.alloc(1).writeUint8BE(1));
            else if(character[i].skill[j].target == "friend") fs.writeSync(output, Buffer.alloc(1).writeUint8BE(2));
            else if(character[i].skill[j].target == "all-enemies") fs.writeSync(output, Buffer.alloc(1).writeUint8BE(3));
            else if(character[i].skill[j].target == "all-friends") fs.writeSync(output, Buffer.alloc(1).writeUint8BE(4));
            else if(character[i].skill[j].target == "all") fs.writeSync(output, Buffer.alloc(1).writeUint8BE(5));
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].skill[j].effect.base));
            fs.writeSync(output, Buffer.alloc(4).writeUint32BE(character[i].skill[j].effect.magnification));
            fs.writeSync(output, Buffer.alloc(1).writeUint8BE(character[i].skill[j].effect.cd));
            fs.writeSync(output, Buffer.alloc(1).writeUint8BE(character[i].skill[j].obtain.length));
            fs.writeSync(output, character[i].skill[j].obtain);
        }
    }
    console.log("Done.");
}catch(e){
    consoBE.error(e);
    process.exit(1);
}