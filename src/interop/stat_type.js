var stats = {
    0: "getServerLoad",
    1: "getPeakServerLoad",
    2: "getAverageServerLoad"
};

`round((${stats[type]}() / 255) * 100)`;
