import {
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
  import { expect } from "chai";
  import { ethers } from "hardhat";

  const testString = "Hello World!";

  describe("String", function () {

    async function deployUseString() {
        const UseString = await ethers.getContractFactory("ExampleString");
        const useString = await UseString.deploy();

        return useString;

    }

    describe("Deployment", function () {
        it("Should set string as written", async function () {
            const useString = await loadFixture(deployUseString);
            console.log("Deployed")

            let tx = await useString.setString(testString);
            await tx.wait();

            let response = await useString.someString();
            console.log("        ", response);
            expect(await useString.someString()).to.equal(testString);

        });
        it("Check string toLowerCase()", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setLowerCaseString(testString);
            tx.wait();

            let response = await useString.someString();
            console.log("        ", response);
            expect(await useString.someString()).to.equal(testString.toLowerCase());
        });
        it("Check string toUpperCase()", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setUpperCaseString(testString);
            tx.wait();

            let response = await useString.someString();
            console.log("        ", response);
            expect(await useString.someString()).to.equal(testString.toUpperCase());
        });

        it("Check string length", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setLength(testString);
            tx.wait();

            let response = await useString.someUint();
            console.log("        ", response);
            expect(await useString.someUint()).to.equal(testString.length);
        });

        it("Check charAt(1)", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setCharAt(testString, 1);
            tx.wait();

            let response = await useString.someString();
            console.log("        ", response);
            expect(await useString.someString()).to.equal(testString.charAt(1));
        });

        it("Check startsWith('Hell')", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setStartsWith(testString, testString.slice(0, 3));
            tx.wait();

            let response = await useString.someBool();
            console.log("        ", response);
            expect(await useString.someBool()).to.equal(true);
        });

        it("Check endsWith('rld!')", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setEndsWith(testString, testString.slice(-4));
            tx.wait();

            let response = await useString.someBool();
            console.log("        ", response);
            expect(await useString.someBool()).to.equal(true);
        });

        it("Check includes('World!')", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setIncludes(testString, "World!");
            tx.wait();

            let response = await useString.someBool();
            console.log("        ", response);
            expect(await useString.someBool()).to.equal(true);
        });

        it("Check equals('Hello World!')", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setEquals(testString, "Hello World!");
            tx.wait();

            let response = await useString.someBool();
            console.log("        ", response);
            expect(await useString.someBool()).to.equal(true);
        });

        it("Check indexOf('l')", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setIndexOf(testString, "l");
            tx.wait();
            
            let response = await useString.someUint();
            console.log("        ", response);
            expect(await useString.someUint()).to.equal(testString.indexOf("l"));
        });

        it("Check lastIndexOf('World!')", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setLastIndexOf(testString, "World!");
            tx.wait();
            
            let response = await useString.someUint();
            console.log("        ", response);
            expect(await useString.someUint()).to.equal(testString.lastIndexOf("World!"));
        });

        it("Check slice(0, -4)", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setSlice(testString, 0, -4);
            tx.wait();
            
            let response = await useString.someString();
            console.log("        ", response);
            expect(await useString.someString()).to.equal(testString.slice(0, -4));
        });

        it("Check split('o') index 0", async function () {
            const useString = await loadFixture(deployUseString);

            let tx = await useString.setSplit(testString, "o");
            tx.wait();
            
            let response = await useString.someStringArray(0);
            console.log("        ", response);
            expect(await useString.someStringArray(0)).to.equal(testString.split("o")[0]);
        });

    });
    
  });