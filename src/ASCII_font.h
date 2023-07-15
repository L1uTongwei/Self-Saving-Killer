#pragma once
#include "header.h"
byte ASCII_font[256][6];
void init_ASCII_font(){
    // A
    ASCII_font['A'][0] = 0b00001100;
    ASCII_font['A'][1] = 0b00010010;
    ASCII_font['A'][2] = 0b00100001;
    ASCII_font['A'][3] = 0b00111111;
    ASCII_font['A'][4] = 0b00100001;
    ASCII_font['A'][5] = 0b00100001;
    // B
    ASCII_font['B'][0] = 0b00111110;
    ASCII_font['B'][1] = 0b00100001;
    ASCII_font['B'][2] = 0b00111110;
    ASCII_font['B'][3] = 0b00100001;
    ASCII_font['B'][4] = 0b00100001;
    ASCII_font['B'][5] = 0b00111110;
    // C
    ASCII_font['C'][0] = 0b00011110;
    ASCII_font['C'][1] = 0b00100001;
    ASCII_font['C'][2] = 0b00100000;
    ASCII_font['C'][3] = 0b00100000;
    ASCII_font['C'][4] = 0b00100001;
    ASCII_font['C'][5] = 0b00011110;
    // D
    ASCII_font['D'][0] = 0b00111110;
    ASCII_font['D'][1] = 0b00100001;
    ASCII_font['D'][2] = 0b00100001;
    ASCII_font['D'][3] = 0b00100001;
    ASCII_font['D'][4] = 0b00100001;
    ASCII_font['D'][5] = 0b00111110;
    // E
    ASCII_font['E'][0] = 0b00111111;
    ASCII_font['E'][1] = 0b00100000;
    ASCII_font['E'][2] = 0b00111110;
    ASCII_font['E'][3] = 0b00100000;
    ASCII_font['E'][4] = 0b00100000;
    ASCII_font['E'][5] = 0b00111111;
    // F
    ASCII_font['F'][0] = 0b00111111;
    ASCII_font['F'][1] = 0b00100000;
    ASCII_font['F'][2] = 0b00111110;
    ASCII_font['F'][3] = 0b00100000;
    ASCII_font['F'][4] = 0b00100000;
    ASCII_font['F'][5] = 0b00100000;
    // G
    ASCII_font['G'][0] = 0b00011110;
    ASCII_font['G'][1] = 0b00100001;
    ASCII_font['G'][2] = 0b00100000;
    ASCII_font['G'][3] = 0b00100111;
    ASCII_font['G'][4] = 0b00100001;
    ASCII_font['G'][5] = 0b00011110;
    // H
    ASCII_font['H'][0] = 0b00100001;
    ASCII_font['H'][1] = 0b00100001;
    ASCII_font['H'][2] = 0b00111111;
    ASCII_font['H'][3] = 0b00100001;
    ASCII_font['H'][4] = 0b00100001;
    ASCII_font['H'][5] = 0b00100001;
    // I
    ASCII_font['I'][0] = 0b00000100;
    ASCII_font['I'][1] = 0b00000100;
    ASCII_font['I'][2] = 0b00000100;
    ASCII_font['I'][3] = 0b00000100;
    ASCII_font['I'][4] = 0b00000100;
    ASCII_font['I'][5] = 0b00000100;
    // J
    ASCII_font['J'][0] = 0b00000001;
    ASCII_font['J'][1] = 0b00000001;
    ASCII_font['J'][2] = 0b00000001;
    ASCII_font['J'][3] = 0b00000001;
    ASCII_font['J'][4] = 0b00100001;
    ASCII_font['J'][5] = 0b00011110;
    // K
    ASCII_font['K'][0] = 0b00100001;
    ASCII_font['K'][1] = 0b00100010;
    ASCII_font['K'][2] = 0b00111100;
    ASCII_font['K'][3] = 0b00100100;
    ASCII_font['K'][4] = 0b00100010;
    ASCII_font['K'][5] = 0b00100001;
    // L
    ASCII_font['L'][0] = 0b00100000;
    ASCII_font['L'][1] = 0b00100000;
    ASCII_font['L'][2] = 0b00100000;
    ASCII_font['L'][3] = 0b00100000;
    ASCII_font['L'][4] = 0b00100000;
    ASCII_font['L'][5] = 0b00111111;
    // M
    ASCII_font['M'][0] = 0b00100001;
    ASCII_font['M'][1] = 0b00110011;
    ASCII_font['M'][2] = 0b00101101;
    ASCII_font['M'][3] = 0b00100001;
    ASCII_font['M'][4] = 0b00100001;
    ASCII_font['M'][5] = 0b00100001;
    // N
    ASCII_font['N'][0] = 0b00100001;
    ASCII_font['N'][1] = 0b00110001;
    ASCII_font['N'][2] = 0b00101001;
    ASCII_font['N'][3] = 0b00100101;
    ASCII_font['N'][4] = 0b00100011;
    ASCII_font['N'][5] = 0b00100001;
    // O
    ASCII_font['O'][0] = 0b00011110;
    ASCII_font['O'][1] = 0b00100001;
    ASCII_font['O'][2] = 0b00100001;
    ASCII_font['O'][3] = 0b00100001;
    ASCII_font['O'][4] = 0b00100001;
    ASCII_font['O'][5] = 0b00011110;
    // P
    ASCII_font['P'][0] = 0b00111110;
    ASCII_font['P'][1] = 0b00100001;
    ASCII_font['P'][2] = 0b00100001;
    ASCII_font['P'][3] = 0b00111110;
    ASCII_font['P'][4] = 0b00100000;
    ASCII_font['P'][5] = 0b00100000;
    // Q
    ASCII_font['Q'][0] = 0b00011110;
    ASCII_font['Q'][1] = 0b00100001;
    ASCII_font['Q'][2] = 0b00100001;
    ASCII_font['Q'][3] = 0b00100101;
    ASCII_font['Q'][4] = 0b00100010;
    ASCII_font['Q'][5] = 0b00011101;
    // R
    ASCII_font['R'][0] = 0b00111110;
    ASCII_font['R'][1] = 0b00100001;
    ASCII_font['R'][2] = 0b00100001;
    ASCII_font['R'][3] = 0b00111110;
    ASCII_font['R'][4] = 0b00100010;
    ASCII_font['R'][5] = 0b00100001;
    // S
    ASCII_font['S'][0] = 0b00011110;
    ASCII_font['S'][1] = 0b00100000;
    ASCII_font['S'][2] = 0b00011110;
    ASCII_font['S'][3] = 0b00000001;
    ASCII_font['S'][4] = 0b00100001;
    ASCII_font['S'][5] = 0b00011110;
    // T
    ASCII_font['T'][0] = 0b00011111;
    ASCII_font['T'][1] = 0b00000100;
    ASCII_font['T'][2] = 0b00000100;
    ASCII_font['T'][3] = 0b00000100;
    ASCII_font['T'][4] = 0b00000100;
    ASCII_font['T'][5] = 0b00000100;
    // U
    ASCII_font['U'][0] = 0b00100001;
    ASCII_font['U'][1] = 0b00100001;
    ASCII_font['U'][2] = 0b00100001;
    ASCII_font['U'][3] = 0b00100001;
    ASCII_font['U'][4] = 0b00100001;
    ASCII_font['U'][5] = 0b00011110;
    // V
    ASCII_font['V'][0] = 0b00100001;
    ASCII_font['V'][1] = 0b00100001;
    ASCII_font['V'][2] = 0b00100001;
    ASCII_font['V'][3] = 0b00100001;
    ASCII_font['V'][4] = 0b00010010;
    ASCII_font['V'][5] = 0b00001100;
    // W
    ASCII_font['W'][0] = 0b00100001;
    ASCII_font['W'][1] = 0b00100001;
    ASCII_font['W'][2] = 0b00100001;
    ASCII_font['W'][3] = 0b00101101;
    ASCII_font['W'][4] = 0b00110011;
    ASCII_font['W'][5] = 0b00100001;
    // X
    ASCII_font['X'][0] = 0b00100001;
    ASCII_font['X'][1] = 0b00010010;
    ASCII_font['X'][2] = 0b00001100;
    ASCII_font['X'][3] = 0b00001100;
    ASCII_font['X'][4] = 0b00010010;
    ASCII_font['X'][5] = 0b00100001;
    // Y
    ASCII_font['Y'][0] = 0b00010001;
    ASCII_font['Y'][1] = 0b00001010;
    ASCII_font['Y'][2] = 0b00000100;
    ASCII_font['Y'][3] = 0b00000100;
    ASCII_font['Y'][4] = 0b00000100;
    ASCII_font['Y'][5] = 0b00000100;
    // Z
    ASCII_font['Z'][0] = 0b00111111;
    ASCII_font['Z'][1] = 0b00000010;
    ASCII_font['Z'][2] = 0b00000100;
    ASCII_font['Z'][3] = 0b00001000;
    ASCII_font['Z'][4] = 0b00010000;
    ASCII_font['Z'][5] = 0b00111111;
    // 1
    ASCII_font['1'][0] = 0b00001000;
    ASCII_font['1'][1] = 0b00011000;
    ASCII_font['1'][2] = 0b00001000;
    ASCII_font['1'][3] = 0b00001000;
    ASCII_font['1'][4] = 0b00001000;
    ASCII_font['1'][5] = 0b00111110;
    // 2
    ASCII_font['2'][0] = 0b00011110;
    ASCII_font['2'][1] = 0b00100001;
    ASCII_font['2'][2] = 0b00000001;
    ASCII_font['2'][3] = 0b00011110;
    ASCII_font['2'][4] = 0b00100000;
    ASCII_font['2'][5] = 0b00111111;
    // 3
    ASCII_font['3'][0] = 0b00011110;
    ASCII_font['3'][1] = 0b00100001;
    ASCII_font['3'][2] = 0b00000001;
    ASCII_font['3'][3] = 0b00011110;
    ASCII_font['3'][4] = 0b00100001;
    ASCII_font['3'][5] = 0b00011111;
    // 4
    ASCII_font['4'][0] = 0b00100000;
    ASCII_font['4'][1] = 0b00100010;
    ASCII_font['4'][2] = 0b00111111;
    ASCII_font['4'][3] = 0b00000010;
    ASCII_font['4'][4] = 0b00000010;
    ASCII_font['4'][5] = 0b00000010;
    // 5
    ASCII_font['5'][0] = 0b00111111;
    ASCII_font['5'][1] = 0b00100000;
    ASCII_font['5'][2] = 0b00100000;
    ASCII_font['5'][3] = 0b00011110;
    ASCII_font['5'][4] = 0b00000001;
    ASCII_font['5'][5] = 0b00111111;
    // 6
    ASCII_font['6'][0] = 0b00011111;
    ASCII_font['6'][1] = 0b00100000;
    ASCII_font['6'][2] = 0b00100000;
    ASCII_font['6'][3] = 0b00111111;
    ASCII_font['6'][4] = 0b00100001;
    ASCII_font['6'][5] = 0b00111111;
    // 7
    ASCII_font['7'][0] = 0b00111111;
    ASCII_font['7'][1] = 0b00000001;
    ASCII_font['7'][2] = 0b00000100;
    ASCII_font['7'][3] = 0b00001000;
    ASCII_font['7'][4] = 0b00001000;
    ASCII_font['7'][5] = 0b00001000;
    // 8
    ASCII_font['8'][0] = 0b00011110;
    ASCII_font['8'][1] = 0b00100001;
    ASCII_font['8'][2] = 0b00100001;
    ASCII_font['8'][3] = 0b00011110;
    ASCII_font['8'][4] = 0b00100001;
    ASCII_font['8'][5] = 0b00011110;
    // 9
    ASCII_font['9'][0] = 0b00011110;
    ASCII_font['9'][1] = 0b00100001;
    ASCII_font['9'][2] = 0b00100001;
    ASCII_font['9'][3] = 0b00011111;
    ASCII_font['9'][4] = 0b00000001;
    ASCII_font['9'][5] = 0b00111111;
    // 0
    ASCII_font['0'][0] = 0b00011110;
    ASCII_font['0'][1] = 0b00110001;
    ASCII_font['0'][2] = 0b00101001;
    ASCII_font['0'][3] = 0b00100101;
    ASCII_font['0'][4] = 0b00100011;
    ASCII_font['0'][5] = 0b00011110;
    // 
    ASCII_font[' '][0] = 0b00000000;
    ASCII_font[' '][1] = 0b00000000;
    ASCII_font[' '][2] = 0b00000000;
    ASCII_font[' '][3] = 0b00000000;
    ASCII_font[' '][4] = 0b00000000;
    ASCII_font[' '][5] = 0b00000000;
    // !
    ASCII_font['!'][0] = 0b00011100;
    ASCII_font['!'][1] = 0b00011100;
    ASCII_font['!'][2] = 0b00011100;
    ASCII_font['!'][3] = 0b00001000;
    ASCII_font['!'][4] = 0b0000000;
    ASCII_font['!'][5] = 0b00011100;
    // "
    ASCII_font['"'][0] = 0b00110011;
    ASCII_font['"'][1] = 0b00110011;
    ASCII_font['"'][2] = 0b00000000;
    ASCII_font['"'][3] = 0b00000000;
    ASCII_font['"'][4] = 0b00000000;
    ASCII_font['"'][5] = 0b00000000;
    // #
    ASCII_font['#'][0] = 0b00001010;
    ASCII_font['#'][1] = 0b00001010;
    ASCII_font['#'][2] = 0b00111111;
    ASCII_font['#'][3] = 0b00111111;
    ASCII_font['#'][4] = 0b00001010;
    ASCII_font['#'][5] = 0b00001010;
    // $
    ASCII_font['$'][0] = 0b00011110;
    ASCII_font['$'][1] = 0b00100101;
    ASCII_font['$'][2] = 0b00100100;
    ASCII_font['$'][3] = 0b00011110;
    ASCII_font['$'][4] = 0b00000101;
    ASCII_font['$'][5] = 0b00011110;
    // '
    ASCII_font['\''][0] = 0b00011100;
    ASCII_font['\''][1] = 0b00011100;
    ASCII_font['\''][2] = 0b00000100;
    ASCII_font['\''][3] = 0b00001000;
    ASCII_font['\''][4] = 0b00000000;
    ASCII_font['\''][5] = 0b00000000;
    // (
    ASCII_font['('][0] = 0b00001100;
    ASCII_font['('][1] = 0b00010010;
    ASCII_font['('][2] = 0b00100000;
    ASCII_font['('][3] = 0b00100000;
    ASCII_font['('][4] = 0b00010000;
    ASCII_font['('][5] = 0b00001100;
    // )
    ASCII_font[')'][0] = 0b00011000;
    ASCII_font[')'][1] = 0b00000100;
    ASCII_font[')'][2] = 0b00000010;
    ASCII_font[')'][3] = 0b00000010;
    ASCII_font[')'][4] = 0b00000100;
    ASCII_font[')'][5] = 0b00011000;
    // *
    ASCII_font['*'][0] = 0b00010001;
    ASCII_font['*'][1] = 0b00001010;
    ASCII_font['*'][2] = 0b00111111;
    ASCII_font['*'][3] = 0b00001010;
    ASCII_font['*'][4] = 0b00010001;
    ASCII_font['*'][5] = 0b00000000;
    // +
    ASCII_font['+'][0] = 0b00000100;
    ASCII_font['+'][1] = 0b00000100;
    ASCII_font['+'][2] = 0b00111111;
    ASCII_font['+'][3] = 0b00000100;
    ASCII_font['+'][4] = 0b00000100;
    ASCII_font['+'][5] = 0b00000000;
    // ,
    ASCII_font[','][0] = 0b00000000;
    ASCII_font[','][1] = 0b00000000;
    ASCII_font[','][2] = 0b00011100;
    ASCII_font[','][3] = 0b00011100;
    ASCII_font[','][4] = 0b00001000;
    ASCII_font[','][5] = 0b00010000;
    // -
    ASCII_font['-'][0] = 0b00000000;
    ASCII_font['-'][1] = 0b00000000;
    ASCII_font['-'][2] = 0b00111111;
    ASCII_font['-'][3] = 0b00000000;
    ASCII_font['-'][4] = 0b00000000;
    ASCII_font['-'][5] = 0b00000000;
    // .
    ASCII_font['.'][0] = 0b00000000;
    ASCII_font['.'][1] = 0b00000000;
    ASCII_font['.'][2] = 0b00000000;
    ASCII_font['.'][3] = 0b00011100;
    ASCII_font['.'][4] = 0b00011100;
    ASCII_font['.'][5] = 0b00011100;
    // /
    ASCII_font['/'][0] = 0b00000001;
    ASCII_font['/'][1] = 0b00000010;
    ASCII_font['/'][2] = 0b00000100;
    ASCII_font['/'][3] = 0b00001000;
    ASCII_font['/'][4] = 0b00010000;
    ASCII_font['/'][5] = 0b00100000;
    // :
    ASCII_font[':'][0] = 0b00001000;
    ASCII_font[':'][1] = 0b00010100;
    ASCII_font[':'][2] = 0b00001000;
    ASCII_font[':'][3] = 0b00001000;
    ASCII_font[':'][4] = 0b00011100;
    ASCII_font[':'][5] = 0b00001000;
    // ;
    ASCII_font[';'][0] = 0b00011100;
    ASCII_font[';'][1] = 0b00011100;
    ASCII_font[';'][2] = 0b00000000;
    ASCII_font[';'][3] = 0b00011100;
    ASCII_font[';'][4] = 0b0000100;
    ASCII_font[';'][5] = 0b00010000;
    // <
    ASCII_font['<'][0] = 0b00000100;
    ASCII_font['<'][1] = 0b00001000;
    ASCII_font['<'][2] = 0b00010000;
    ASCII_font['<'][3] = 0b00100000;
    ASCII_font['<'][4] = 0b00010000;
    ASCII_font['<'][5] = 0b00000000;
    // =
    ASCII_font['='][0] = 0b00000000;
    ASCII_font['='][1] = 0b00000000;
    ASCII_font['='][2] = 0b00111111;
    ASCII_font['='][3] = 0b00000000;
    ASCII_font['='][4] = 0b00111111;
    ASCII_font['='][5] = 0b00000000;
    // >
    ASCII_font['>'][0] = 0b00010000;
    ASCII_font['>'][1] = 0b00001000;
    ASCII_font['>'][2] = 0b00000100;
    ASCII_font['>'][3] = 0b00001000;
    ASCII_font['>'][4] = 0b00010000;
    ASCII_font['>'][5] = 0b00000000;
    // ?
    ASCII_font['?'][0] = 0b00011110;
    ASCII_font['?'][1] = 0b00100001;
    ASCII_font['?'][2] = 0b00000001;
    ASCII_font['?'][3] = 0b00000110;
    ASCII_font['?'][4] = 0b00000000;
    ASCII_font['?'][5] = 0b00000100;
    // @
    ASCII_font['@'][0] = 0b00111111;
    ASCII_font['@'][1] = 0b00100001;
    ASCII_font['@'][2] = 0b00101101;
    ASCII_font['@'][3] = 0b00101110;
    ASCII_font['@'][4] = 0b00100011;
    ASCII_font['@'][5] = 0b00111111;
    // ^
    ASCII_font['^'][0] = 0b00001000;
    ASCII_font['^'][1] = 0b00010100;
    ASCII_font['^'][2] = 0b00100010;
    ASCII_font['<'][3] = 0b00000000;
    ASCII_font['<'][4] = 0b00000000;
    ASCII_font['<'][5] = 0b00000000;
    // %
    ASCII_font['%'][0] = 0b00111001;
    ASCII_font['%'][1] = 0b00111010;
    ASCII_font['%'][2] = 0b00000100;
    ASCII_font['%'][3] = 0b00001000;
    ASCII_font['%'][4] = 0b00010111;
    ASCII_font['%'][5] = 0b00100111;
    // &
    ASCII_font['&'][0] = 0b00001100;
    ASCII_font['&'][1] = 0b00010010;
    ASCII_font['&'][2] = 0b00001100;
    ASCII_font['&'][3] = 0b00011101;
    ASCII_font['&'][4] = 0b00100010;
    ASCII_font['&'][5] = 0b00011101;
    // _
    ASCII_font['_'][0] = 0b00000000;
    ASCII_font['_'][1] = 0b00000000;
    ASCII_font['_'][2] = 0b00000000;
    ASCII_font['_'][3] = 0b00000000;
    ASCII_font['_'][4] = 0b00000000;
    ASCII_font['_'][5] = 0b00111111;
    // `
    ASCII_font['`'][0] = 0b00011100;
    ASCII_font['`'][1] = 0b00011100;
    ASCII_font['`'][2] = 0b00001000;
    ASCII_font['`'][3] = 0b00000100;
    ASCII_font['`'][4] = 0b00000000;
    ASCII_font['`'][5] = 0b00000000;
    // [
    ASCII_font['['][0] = 0b00111111;
    ASCII_font['['][1] = 0b00100000;
    ASCII_font['['][2] = 0b00100000;
    ASCII_font['['][3] = 0b00100000;
    ASCII_font['['][4] = 0b00100000;
    ASCII_font['['][5] = 0b00111111;
    // ]
    ASCII_font[']'][0] = 0b00111111;
    ASCII_font[']'][1] = 0b00000001;
    ASCII_font[']'][2] = 0b00000001;
    ASCII_font[']'][3] = 0b00000001;
    ASCII_font[']'][4] = 0b00000001;
    ASCII_font[']'][5] = 0b00111111;
    // \
    there are a extend line
    ASCII_font['\\'][0] = 0b00100000;
    ASCII_font['\\'][1] = 0b00010000;
    ASCII_font['\\'][2] = 0b00001000;
    ASCII_font['\\'][3] = 0b00000100;
    ASCII_font['\\'][4] = 0b00000010;
    ASCII_font['\\'][5] = 0b00000001;
    // {
    ASCII_font['{'][0] = 0b00001110;
    ASCII_font['{'][1] = 0b00010000;
    ASCII_font['{'][2] = 0b00010000;
    ASCII_font['{'][3] = 0b00110000;
    ASCII_font['{'][4] = 0b00010000;
    ASCII_font['{'][5] = 0b00001110;
    // }
    ASCII_font['}'][0] = 0b00011100;
    ASCII_font['}'][1] = 0b00000010;
    ASCII_font['}'][2] = 0b00000010;
    ASCII_font['}'][3] = 0b00000011;
    ASCII_font['}'][4] = 0b00000010;
    ASCII_font['}'][5] = 0b00011100;
    // |
    ASCII_font['|'][0] = 0b00001000;
    ASCII_font['|'][1] = 0b00001000;
    ASCII_font['|'][2] = 0b00001000;
    ASCII_font['|'][3] = 0b00001000;
    ASCII_font['|'][4] = 0b00001000;
    ASCII_font['|'][5] = 0b00001000;
}
byte* get_ASCII_font(unsigned char ch){
    return ASCII_font[ch];
}