//SSKgenerater.js
//用于将你的 SSK 项目编译为 SSK 包来加载运行
const fs = require('fs');
const opentype = require('opentype.js');
var fontGenerater = (text, font) => {
    var path = font.getPath(text);
    return path.glyphs;
};
var calcFileSheet = () => {
    var ret = 4;
    for(var v in structure){
        ret += v.length + 5;
    }
    return ret;
};
var calcFile = () => {
    var ret = 4;
    for(var v in structure){
        ret += fs.statSync(root + v).size + 4;
    }
    return ret;
};
try{
    if(process.argv.length < 5){
        console.log("Usage: node SSKgenerator.js <SSK-path> <SSK-package> <font-file>");
        process.exit(1);
    }
    const font = opentype.loadSync(process.argv[4]);
    var root = process.argv[2];
    var structure = JSON.parse(fs.readFileSync(root + "/structure.json").toString("utf8"));
    var text = JSON.parse(fs.readFileSync(root + "/text.json").toString("utf8"));
    var output = fs.openSync(process.argv[3], "w");
    fs.writeSync(output, "\xffSSK\xff"); //文件类型戳
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(0x05)); //文件表的偏移量
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(0x05 + calcFileSheet())); //程序的偏移量
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(0x05 + calcFileSheet() + fs.statSync(root + "/program.bin").size)); //素材文件的偏移量
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(0x05 + calcFileSheet() + fs.statSync(root + "/program.bin").size) + calcFile()); //文本的偏移量
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(structure.length)); //文件表长度
    for(var v in structure){
        fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(v.length)); //文件名称长度
        fs.writeSync(output, v + '\0');
    }
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(fs.statSync(root + "/program.bin").size)); //程序长度
    fs.writeSync(output, fs.readFileSync(root +"/program.bin"));
    for(var v in structure){
        fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(fs.statSync(root + v).size)); //文件长度
        fs.writeSync(output, fs.readFileSync(root + "/program.bin"));
    }
    fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(fs.statSync(root + "/program.bin").size)); //文本数量
    for(var v in text){
        var res = fontGenerater(v, font);
        fs.writeSync(output, (Buffer.allocUnsafe(4)).writeUInt32BE(res.size)); //文本长度
        fs.writeSync(output, res);
    }
    console.log("Done.");
}catch(e){
    console.error(e);
    process.exit(1);
}