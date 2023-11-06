export function formatPhone(number) {

    if(number.length < 10 || number.length > 10) {
        return number;
    }

    return "(" + number.slice(0,3) + ") " + number.slice(3,6) + "-" + number.slice(6);

}