import { useNavigate } from 'react-router-dom'

function Header({item}) {
    return <th>{item}</th>
}

function Cell({item}) {
    return <td>{item}</td>
}

export default function Row({type, items, link}) {

    var cells = []

    const navigate = useNavigate();

    for (var i = 0; i < items.length; i++) {
        if(type === 'header') {
            cells.push(<Header item = {items[i]} />);
        }
        else {
            cells.push(<Cell item = {items[i]} />);
        }
    }

    return (
            <tr className="tableRow" onClick={() => navigate(link)}>
                {cells}
            </tr>
    )

}