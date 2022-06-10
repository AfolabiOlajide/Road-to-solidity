const ethers = require("ethers");

async function createString(args) {
	const bytes = args[0];
	const name = ethers.utils.parseBytes32String(bytes);

	console.log("name: ", name);
}

createString(process.argv.slice(2));
